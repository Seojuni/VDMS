import mariadb
import db_conn


def db_init():
    conn = db_conn.db_conn()
    cur = conn.cursor()
    
    try:
        cur.execute("""create table cve_list (
            vuln_id VARCHAR(15) NOT NULL PRIMARY KEY,
            pub_date VARCHAR(10) NOT NULL,
            last_mod_date VARCHAR(10) NOT NULL,
            description TEXT(2000) NOT NULL,
            score VARCHAR(5) NOT NULL,
            software VARCHAR(50) NOT NULL,
            start_version VARCHAR(20),
            end_version VARCHAR(20),
            cwe_id VARCHAR(20) NOT NULL,
            cwe_name VARCHAR(100) NOT NULL);""")
        conn.commit()
    
        cur.execute("""create table vuln_list (
            No INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(100) NOT NULL,
            version VARCHAR(30) NOT NULL,
            vuln_id VARCHAR(15));""")
        conn.commit()
    
        cur.execute("""create table software_list (
            No INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(100) NOT NULL,
            version VARCHAR(30) NOT NULL);""")
        conn.commit()
    
        cur.execute("""create table diagnostic_results(
            type_code VARCHAR(5) NOT NULL PRIMARY KEY,
            result VARCHAR(1) NOT NULL);""")
        conn.commit()
    except mariadb.Error as e:
        print(f"Error: {e}")
    
    conn.close()
