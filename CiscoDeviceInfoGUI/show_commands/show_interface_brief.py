from netmiko import ConnectHandler

def show_ip_interface_brief(device):
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

        # Execute the "show ip interface brief" command
        output = conn.send_command("show ip interface brief")

    return output
    