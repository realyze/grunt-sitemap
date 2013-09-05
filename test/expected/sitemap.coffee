# Website Sitemap
# ===============

angular.module('salsitasoft')

.constant('SITEMAP', [
  {
    "title": "fooo",
    "order": 1,
    "id": "home",
    "url": "home",
    "templateUrl": "static/src/app/content/home/index.html",
    "controller": "genericController"
  },
  {
    "title": "My webapps overview",
    "order": 2,
    "id": "web-apps",
    "url": "web-apps",
    "templateUrl": "static/src/app/content/web-apps/index.html",
    "controller": "genericController"
  },
  {
    "id": "something2",
    "order": 1,
    "url": "home/something2",
    "title": "Something2",
    "templateUrl": "static/src/app/content/home/something2.html",
    "controller": "genericController",
    "parent": "home"
  },
  {
    "title": "Something special",
    "order": 2,
    "id": "something",
    "url": "home/something",
    "templateUrl": "static/src/app/content/home/something.html",
    "controller": "genericController",
    "parent": "home"
  },
  {
    "id": "level",
    "url": "web-apps/level",
    "title": "Level",
    "templateUrl": "static/src/app/content/web-apps/level/index.html",
    "controller": "genericController",
    "parent": "web-apps",
    "order": 0
  },
  {
    "title": "My webapps TEST overview (sublevel)",
    "id": "test",
    "url": "web-apps/level/test",
    "templateUrl": "static/src/app/content/web-apps/level/test.html",
    "controller": "genericController",
    "parent": "level",
    "order": 0
  }
])
