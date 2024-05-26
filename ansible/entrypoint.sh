#!/bin/bash
ulimit -n 65536

echo "hacluster:123" | chpasswd

# rm -rf /etc/corosync/corosync.conf
pcs cluster destroy --force
# cp corosync.conf /etc/corosync/corosync.conf
# supervisorctl reread && supervisorctl update all && supervisorctl restart

/usr/local/bin/supervisord -n -c /etc/supervisor/supervisord.conf &

ansible-playbook -i ansible/inventory/inventory ansible/playbooks/playbook_main.yml

# Запустить бесконечный цикл, чтобы контейнер не завершил выполнение
tail -f /dev/null
