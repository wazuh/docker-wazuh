import logging
import sys
import json
import random
import string
import os
import re
# Set framework path
sys.path.append(os.path.dirname(sys.argv[0]) + "/../framework")
USER_FILE_PATH = "/var/ossec/api/configuration/admin.json"
WUI_USER_FILE_PATH = "/var/ossec/api/configuration/wui-user.json"
try:
    from wazuh.security import (
        create_user,
        get_users,
        get_roles,
        set_user_role,
        update_user,
    )
except Exception as e:
    logging.error("No module 'wazuh' found.")
    sys.exit(1)
def read_user_file(path=USER_FILE_PATH):
    with open(path) as user_file:
        data = json.load(user_file)
        return data["username"], data["password"]
def read_wui_user_file(path=WUI_USER_FILE_PATH):
    with open(path) as wui_user_file:
        data = json.load(wui_user_file)
        return data["password"]
def db_users():
    users_result = get_users()
    return {user["username"]: user["id"] for user in users_result.affected_items}
def db_roles():
    roles_result = get_roles()
    return {role["name"]: role["id"] for role in roles_result.affected_items}
if __name__ == "__main__":
    if not os.path.exists(USER_FILE_PATH):
        # abort if no user file detected
        sys.exit(0)
    username, password = read_user_file()
    wui_password = read_wui_user_file()
    initial_users = db_users()
    if username not in initial_users:
        # create a new user
        _user_password = re.compile(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$')
        if not _user_password.match(password):
            FAIL
        create_user(username=username, password=password)
        users = db_users()
        uid = users[username]
        roles = db_roles()
        rid = roles["administrator"]
        set_user_role(
            user_id=[
                str(uid),
            ],
            role_ids=[
                str(rid),
            ],
        )
    else:
        # modify an existing user ("wazuh" or "wazuh-wui")
        uid = initial_users[username]
        update_user(
            user_id=[
                str(uid),
            ],
            password=password,
        )
    # set a random password for all other users
    for name, id in initial_users.items():
        if name == "wazuh-wui":
            random_pass = wui_password
        elif name == "wazuh":
            random_pass = ([random.choice("@$!%*?&-_"),
                        random.choice(string.digits),
                        random.choice(string.ascii_lowercase),
                        random.choice(string.ascii_uppercase),
                        ]
                        + [random.choice(string.ascii_lowercase
                                        + string.ascii_uppercase
                                        + "@$!%*?&-_"
                                        + string.digits) for i in range(12)])

            random.shuffle(random_pass)
            random_pass = ''.join(random_pass)

        update_user(
            user_id=[
                str(id),
            ],
            password=random_pass,
        )