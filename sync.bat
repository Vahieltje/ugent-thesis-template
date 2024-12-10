@echo off
echo Script started >> C:\Users\tvgiel\Scripts\sync_log.txt
cd "C:\Users\tvgiel\AppData\Roaming\typst\packages\local\ugent-thesis-template" || exit
git add .
git commit -m "Automated commit - %date% %time%"
git pull origin main
git push origin main
echo Script finished >> "C:\Users\tvgiel\AppData\Roaming\typst\packages\local\ugent-thesis-template\sync_log.txt"
