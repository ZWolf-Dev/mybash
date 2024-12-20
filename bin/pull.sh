#! bash bin
echo "start pull from branch"
git pull
echo "run yarn prod"
yarn prod
echo "check status"
git status
echo "add file modified"
git add .
git add .
echo "commit push image"
git commit -m "push image"
echo "git push"
git push
