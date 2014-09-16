# vim: sts=2 ts=2 sw=2 et autoindent
{% if grains['os'] == 'Ubuntu' %}
ssh:
  pkg:
    - installed
  service.running:
    - watch:
      - file: /etc/ssh/sshd_config
    - require:
      - pkg: ssh

/etc/ssh/sshd_config:
  file.managed:
    - mode: 644
    - source: salt://ssh/sshd_config
    - user: root
    - group: root
    - require:
      - pkg: ssh
{% elif grains['os'] == 'FreeBSD' %}
sshd:
  service.running:
    - watch:
      - file: /etc/ssh/sshd_config

/etc/ssh/sshd_config:
  file.managed:
    - mode: 644
    - source: salt://ssh/sshd_config_freebsd
    - user: root
    - group: wheel 
{% endif %}
