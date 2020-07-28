{%- if '_errors' in pillar.networks %}
  {{ raise('Errors in networks pillar: ' ~ pillar.networks._errors) }}
{%- endif %}

{%- set control_plane_ip = salt['metalk8s_network.get_ip_from_cidrs'](
          pillar.networks.control_plane.cidr,
          current_ip=grains.get('metalk8s', {}).get('control_plane_ip')
) %}

{%- if control_plane_ip %}

Set control_plane_ip grain:
  grains.present:
    - name: metalk8s:control_plane_ip
    - value: {{ control_plane_ip }}

{%- else %}

No control-plane network interface present on the host:
  test.fail_without_changes

{%- endif %}

{%- set workload_plane_ip = salt['metalk8s_network.get_ip_from_cidrs'](
          pillar.networks.workload_plane.cidr,
          current_ip=grains.get('metalk8s', {}).get('workload_plane_ip')
) %}

{%- if workload_plane_ip %}

Set workload_plane_ip grain:
  grains.present:
    - name: metalk8s:workload_plane_ip
    - value: {{ workload_plane_ip }}

{%- else %}

No workload-plane network interface present on the host:
  test.fail_without_changes

{%- endif %}
