# Website Sitemap
# ===============
# This is where you can add/edit pages. Just modify the CSON below.


angular.module('salsitasoft')

# Please:
#  * Eat your vegetables.
#  * Comment your code.
#  * Don't put a trailing slash in front of the `url`s in the `SITEMAP`. It
#    breaks stuff when the app is served on a path (i.e. not from root).
#
.constant('SITEMAP', <%= sitemap %>)
