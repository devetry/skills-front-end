export PATH="$HOME/.composer/vendor/bin:$PATH"
couscous generate
cp CNAME .couscous/generated/CNAME
touch .couscous/generated/.nojekyll
gh-pages -d ./.couscous/generated -t