Данная версия скрипта предназначена для:
1) Установки системы на свежесозданный зашифрованный по паролю раздел внутри уже существующего не зашифрованного LVM
2) Для boot создаётся новый том, на уже существующем btrfs-разделе (при желании этот раздел может быть на съёмном носителе)
3) Установчный скрипт расчитан на пк с uefi. 
Для более старых пк (например до 2012 года) с простым биосом скрипт требует небольшой модикации (efi-раздел при желании тоже может быть на внешнем носителе)
4) Если установка происходит с live cd строки для отмонтирования и обратного монтирования /boot/efi нужно закомментировать,
они нужены для установка с уже установленного arch (если efi-раздел примонтирован в /boot, а не /boot/efi эту пару строк тоже надо подправить)

Это узкоспециализированная инсталяция Arch Linux для майнига monero без ничего лишнего, предполагается, что блокчейн монеро закачан на другом разделе, который прописывается в fstab,
если такового нет, то нужно изменить размер раздела с 10Gb до приемлемого
