@echo off
cd "C:\Users\tvgiel\AppData\Roaming\typst\packages\local\ugent-thesis-template"
git add .
git commit -m "Automated commit - %date% %time%"
git pull origin main
git push origin main
