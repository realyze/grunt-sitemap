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
.constant('SITEMAP', [
  title: "fooo"
  id: "home"
  url: "home"
  templateUrl: "static/src/app/content/home/overview.html"
  controller: "genericController"
,
  title: "Something special"
  id: "something"
  url: "home/something"
  templateUrl: "static/src/app/content/home/something.html"
  controller: "genericController"
  parent: "home"
,
  id: "something2"
  url: "home/something2"
  title: "Something2"
  templateUrl: "static/src/app/content/home/something2.html"
  controller: "genericController"
  parent: "home"
,
  id: "level"
  url: "web-apps/level"
  title: "Level"
  templateUrl: "static/src/app/content/web-apps/level/overview.html"
  controller: "genericController"
  parent: "web-apps"
,
  title: "My webapps TEST overview (sublevel)"
  id: "test"
  url: "web-apps/level/test"
  templateUrl: "static/src/app/content/web-apps/level/test.html"
  controller: "genericController"
  parent: "level"
,
  title: "My webapps overview"
  id: "web-apps"
  url: "web-apps"
  templateUrl: "static/src/app/content/web-apps/overview.html"
  controller: "genericController"
])
