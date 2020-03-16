# enable error reporting to the console
set -e
#git add --all
#git commit -a -m $(date +%F_%H-%M-%S) #	2020-02-13_21-25-40
#git push

# clone remote repo to "_site"
#mkdir _site
#git clone https://github.com/jiminjeong22/jiminjeong22.github.io.git _site

# cleanup "_site"
cd _site
rm -rf *
cd ../

# build with Jekyll into "_site"
bundle exec jekyll build

# push
cd _site
git add --all
git commit -a -m $(date +%F_%H-%M-%S)
git push
