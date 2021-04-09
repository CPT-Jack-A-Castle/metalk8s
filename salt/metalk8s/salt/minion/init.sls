#
# State to manage salt minion.
#
# To restart salt-minion:
#   - watch_in:
#     - cmd: Restart salt-minion
#
# Available states
# ================
#
# * restart   -> Restart salt Minion if required `watch_in` set
#

include:
  - .configured
