import requests
from bs4 import BeautifulSoup
import math
import cpe_utils
import mariadb
import db_conn


def insert_data(cur, vuln_id, pub_date, last_mod_date, description, score, software, rangeStartVersion, rangeEndVersion, cwe_id, cwe_name):
    query = 'insert into cve_list(vuln_id, pub_date, last_mod_date, description, score, software, start_version, end_version, cwe_id, cwe_name) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
    
    try:
        cur.execute(query, (vuln_id, pub_date, last_mod_date, description, score, software, rangeStartVersion, rangeEndVersion, cwe_id, cwe_name))
    except mariadb.Error as e:
        print(f"Error: {e}")


def get_data():
    conn = db_conn.db_conn()
    cur = conn.cursor()

    select_query = """select count(*) from cve_list where vuln_id = %s"""

    page_req = requests.get('https://nvd.nist.gov/vuln/search/results?isCpeNameSearch=false&cvss_version=2&results_type=overview&form_type=Advanced&search_type=all&startIndex=0')

    if page_req.ok:
        page_html = page_req.text
        page_soup = BeautifulSoup(page_html, 'html.parser')

        max_records_count = page_soup.select('div > div > strong')[1].get_text()
        max_records_count = ''.join(max_records_count.split(','))
        
        for n in range(0,math.trunc(int(max_records_count)/20)*20+1,20):
            page_req = requests.get('https://nvd.nist.gov/vuln/search/results?isCpeNameSearch=false&cvss_version=2&results_type=overview&form_type=Advanced&search_type=all&startIndex=' + str(n))
            
            if page_req.ok:
                page_html = page_req.text
                page_soup = BeautifulSoup(page_html, 'html.parser')

                for i in range(0,20):
                    if not page_soup.find('a', attrs={'data-testid': 'vuln-detail-link-' + str(i)}):
                        continue
                    
                    vuln_row = page_soup.find('a', attrs={'data-testid': 'vuln-detail-link-'+str(i)}).get_text()

                    try:
                        cur.execute(select_query, [vuln_row])
                    except mariadb.Error as e:
                        print(f"Error: {e}")
                    is_data = cur.fetchone()

                    if is_data[0] == 0:
                        detail_req = requests.get('https://nvd.nist.gov/vuln/detail/' + vuln_row)

                        if detail_req.ok:
                            detail_html = detail_req.text
                            detail_soup = BeautifulSoup(detail_html, 'html.parser')

                            pub_date = detail_soup.find('span', attrs={'data-testid': 'vuln-published-on'}).get_text()

                            last_mod_date = detail_soup.find('span',
                                                             attrs={'data-testid': 'vuln-last-modified-on'}).get_text()

                            description = detail_soup.find('p', attrs={'data-testid': 'vuln-description'}).get_text()

                            if detail_soup.find('a', attrs={'id': 'Cvss3NistCalculatorAnchorNA'}):
                                score = \
                                detail_soup.find('a', attrs={'id': 'Cvss2CalculatorAnchor'}).get_text().split(' ')[0]
                            else:
                                if detail_soup.find('a', attrs={'id': 'Cvss3NistCalculatorAnchor'}) is None:
                                    score = \
                                    detail_soup.find('a', attrs={'id': 'Cvss3CnaCalculatorAnchor'}).get_text().split(
                                        ' ')[0]
                                else:
                                    score = \
                                    detail_soup.find('a', attrs={'id': 'Cvss3NistCalculatorAnchor'}).get_text().split(
                                        ' ')[0]
                            if score == 'N/A':
                                score = \
                                detail_soup.find('a', attrs={'id': 'Cvss2CalculatorAnchor'}).get_text().split(' ')[0]

                            cwe_id = detail_soup.find('td',
                                                      attrs={'data-testid': 'vuln-CWEs-link-0'}).get_text().strip()

                            cwe_name = detail_soup.select('div#vulnTechnicalDetailsDiv > table > tbody > tr > td')[
                                1].get_text()

                            cpe_data = detail_soup.find('input', attrs={'id': 'cveTreeJsonDataHidden'}).get('value')

                            start = cpe_data.find('"cpe22Uri"')
                            end = cpe_data.find('","status"')
                            cpe_code = cpe_data[start + 12:end]
                            vendor = cpe_utils.CPE(cpe_code).get_human("vendor")
                            product = cpe_utils.CPE(cpe_code).get_human("product")
                            if product in vendor or vendor in product:
                                software = product
                            else:
                                software = vendor + " " + product

                            start = cpe_data.find('"rangeStartVersion"')
                            end = cpe_data.find(',"rangeEndType"')
                            rangeStartVersion = cpe_data[start + 20:end]
                            if rangeStartVersion[0] == '"':
                                rangeStartVersion = rangeStartVersion[1:-1]

                            start = cpe_data.find('"rangeEndVersion"')
                            end = cpe_data.find(',"rangeId"')
                            rangeEndVersion = cpe_data[start + 18:end]
                            if rangeEndVersion[0] == '"':
                                rangeEndVersion = rangeEndVersion[1:-1]

                            if rangeStartVersion == '' and rangeEndVersion == '':
                                # rangeStartVersion = cpe_utils.CPE(cpe_code).get_human("version")
                                continue

                            insert_data(cur, vuln_row, pub_date, last_mod_date, description, score, software,
                                        rangeStartVersion, rangeEndVersion, cwe_id, cwe_name)
                            conn.commit()

    conn.close()


if __name__ == "__main__":
    get_data()
