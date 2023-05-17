from netmiko import ConnectHandler 

def show_logging(device):
    device_params = {
        'device_type': 'cisco_ios',
        'ip': device['ip_address'],
        'username': device['username'],
        'password': device['password'],
        'secret': device['secret']
    }

    with ConnectHandler(**device_params) as conn:

        # Enter enable mode
        conn.enable()