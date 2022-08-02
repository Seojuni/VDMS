from plyer import notification


def noti(software, discript):
    notification.notify(
        title='[취약점 발생] ' + software,
        message=discript,
        app_name="Vulnerability Diagnosis and Management",
        app_icon=None,
        timeout=10  # seconds
    )
