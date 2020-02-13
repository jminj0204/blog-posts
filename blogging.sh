# enable error reporting to the console
set -e
git add --all
git commit -a -m "2020"
git push

# cleanup "_site"
rm -rf _site
mkdir _site

# clone remote repo to "_site"
git clone https://github.com/jiminjeong22/jiminjeong22.github.io.git _site

# build with Jekyll into "_site"
bundle exec jekyll build

# push
cd _site
git add --all
git commit -a -m "2020"
git push
