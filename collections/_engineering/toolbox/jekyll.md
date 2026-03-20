---
layout: single
---

Steps I did to use Jekyll on this GitHub pages following this [manual](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll):

1. Install Ruby
2. Install Bundler (```gem install jekyll bundler```)
3. Checkout repo 
4. Move to the root folder with windows command line
5. run ```jekyll new --skip-bundle .```
6. decided to go with [Minimal Mistake](https://jamstackthemes.dev/demo/theme/minimal-mistakes/) theme
7. created _page, _data as standard jekyll folders
8. Decided to use collections
9. run ```bundle exec jekyll serve```

## How to run it locally
[run it locally](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll)

## Add new collection
1. Create new collection in ```_config.yml```
2. Create a folder under "collection" folder with the same name as in ```_config.yml```, but prefixed with underscore.
3. Add a file under ```_pages``` with the same name as defined in ```_config.yml```

## Version on gitHub pages
https://pages.github.com/versions.json 

## Escape content
https://stackoverflow.com/questions/3426182/how-to-escape-liquid-template-tags

![Files involved](/assets/images/tools/jekyll/escaping.PNG)