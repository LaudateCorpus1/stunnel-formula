{% from "stunnel/map.jinja" import stunnel as stunnel_map with context -%}
stunnel:
  pkg.installed:
    - name: {{ stunnel_map.package }}

{{ stunnel_map.conf_dir }}:
  file.directory:
    - user: {{ stunnel_map.default_user }}
    - group: {{ stunnel_map.default_group }}
    - makedirs: True

{{ stunnel_map.conf_dir }}/stunnel.conf:
  file.managed:
    - template: jinja
    - user: {{ stunnel_map.default_user }}
    - group: {{ stunnel_map.default_group }}
    - mode: 644
    - source: salt://stunnel/templates/config.jinja
    - require:
      - file: {{ stunnel_map.conf_dir }}
    - context:
      default_user: {{ stunnel_map.default_user }}
      default_group: {{ stunnel_map.default_group }}
      default_home:  {{ stunnel_map.home }}
      default_pid:  {{ stunnel_map.pid }}

{{ stunnel_map.log_dir }}:
  file.directory:
    - user: {{ stunnel_map.default_user }}
    - group: {{ stunnel_map.default_group }}
    - makedirs: True

{{ stunnel_map.default }}:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - source: salt://stunnel/templates/default.jinja
    - context:
      conf_dir: {{ stunnel_map.conf_dir }}