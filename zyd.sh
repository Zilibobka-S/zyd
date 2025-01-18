#!/bin/bash
#if pacman -Qs yt-dlp mpv &> /dev/null; then
#	echo Загрузка Видео с ютуб
#else 
#	echo "Установи yt-dlp и mpv"
#	exit
#fi
set -x

clear
echo 'откуда куки брать?'

cooki=$(echo -e 'хромиум\nфайрофкс' | fzf  --height=~10   --border=bold)

case $cooki in
хромиум)cookie=chromium
;;
файрфокс)cookie=firefox
;;
esac
clear


echo 'Убрать рекламу?'
sleep 1
sponsorblock=$(echo -e 'да\nнет' | fzf --height=~10 --border=bold)


case $sponsorblock in
"да")
	block="--sponsorblock-remove sponsor"
	;;

"нет") 
	block="--no-sponsorblock"
;;
*)
	block="--no-sponsorblock"
	;;
esac	
echo $block
sleep 1 
clear
echo выбор качества пока сломан
#echo 'есть такие качества:'
#yt-dlp --list-formats "ytsearch:$search"
#sleep 3
echo 'Какое качество?'
sleep 1
quality=$(echo -e '1440p\n1080p\n720\n360p' | fzf)

case $quality in
  1440p)
	video="1440"  # 1440p
    ;;
  1080p)
	video="1080"  # 1080p
    ;;
  720)
	video="720" #720p
    ;;
  360p)
	video="360" #360p    
    ;; 
*)
    echo "Invalid choice, defaulting to 720p"
    format_code="720"  # 720p
    ;;
esac 
echo $video
echo хуяк хуяк и в продакшн

#echo 'Хочешь сохранить видео в ~/Videos/youtube/? (y/n)'
#read choice 
#      if [ "$choice" == "y" ]; then
#	mkdir ~/Videos/youtube
#	place=~/Videos/youtube
#       yt-dlp -o "$place/%(title)s.mp4" "ytsearch:$search" $block
#else 
#	yt-dlp -o "$place/%(title)s.mp4" "ytsearch:$search" $block
#fi
clear

echo а ещё скрипт не умеет выводить нормально длину видео, так как кешируется не всё
echo короче, это бетка, могу исходники кинуть
sleep 0 
echo Ты хочешь 1 - посмотреть видео из подписок, 2 - посмотреть видео из рекомендаций, 3 - посмотреть видео по поиску 
read choice 
case $choice in
3) echo "запрос:"
read search
clear
yt-dlp  "ytsearch:$search" $block -f bestvideo+bestaudio -o - | mpv -
;;
2)echo 'сколько видео хочешь?'
read p
sleep 1
for ((i = 1; i <= p; i++)); do
	yt-dlp :ytrecommend  --mark-watched --cookies-from-browser $cookie --match-filter "!is_live & !watched" --playlist-start $i --force-overwrites --playlist-end $i  -S "+height:$video" -f "bestaudio+bv*[height<=$video]" -o - | mpv -
done
;;
1)yt-dlp :ytsubscriptions 1 --playlist-end 10  --cookies-from-browser $cookie -f bestvideo+bestaudio -o - | mpv -
;; 
esac 
#"!is_live & !watched" yt-dlp  "ytsearch:$search" $block -f $video -o - | mpv -

