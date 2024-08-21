#!/bin/bash

FONT_DIR="${HOME}/.local/share/fonts"
NERD_FONTS_REPO="https://api.github.com/repos/ryanoasis/nerd-fonts"
NERD_FONTS_DOWN="https://github.com/ryanoasis/nerd-fonts/releases/latest/download"

# 폰트 검색 및 선택 함수
search_and_select_font() {
  read -p "검색할 폰트 이름을 입력하세요: " search_term
  echo "검색 중..."

  fonts=$(curl -s "${NERD_FONTS_REPO}/contents/patched-fonts" | grep "name" | cut -d '"' -f 4 | grep -i "$search_term")

  if [ -z "$fonts" ]; then
    echo "검색 결과가 없습니다."
    return 1
  fi

  echo "검색 결과:"
  select font in $fonts; do
    if [ -n "$font" ]; then
      echo "선택한 폰트: $font"
      return 0
    else
      echo "잘못된 선택입니다. 다시 선택해주세요."
    fi
  done
}

# 폰트 설치 함수
install_font() {
  local font_name=$1
  TEMP_DIR=$(mktemp -d)

  LATEST_VERSION=$(curl -s "${NERD_FONTS_REPO}/releases/latest" | grep -oP '"tag_name": "\K(.*)(?=")')

  echo "Downloading ${font_name} Nerd Font..."
  download_url="${NERD_FONTS_DOWN}/${font_name}.tar.xz"
  if curl -LO "$download_url" --output-dir "${TEMP_DIR}" && [ -s "${TEMP_DIR}/${font_name}.tar.xz" ]; then
    mkdir -p "${FONT_DIR}/${font_name}"
    echo "Extracting fonts..."
    if tar -xf "${TEMP_DIR}/${font_name}.tar.xz" -C "${FONT_DIR}/${font_name}"; then
      echo "Updating font cache..."
      fc-cache -f
      echo "Installation complete. ${font_name} Nerd Font has been installed."
    else
      echo "Failed to extract ${font_name}.zip. The file might be corrupted."
      rm -rf "${FONT_DIR}/${font_name}"
    fi
  else
    echo "Failed to download ${font_name}. Please check your internet connection and try again."
  fi
  rm -rf "${TEMP_DIR}"
}

# 설치된 폰트 목록 표시 및 선택 함수
list_and_select_installed_font() {
  local fonts=($(ls -d ${FONT_DIR}/*/ 2>/dev/null | xargs -n 1 basename))

  if [ ${#fonts[@]} -eq 0 ]; then
    echo "설치된 Nerd Font가 없습니다."
    return 1
  fi

  echo "설치된 Nerd Fonts:"
  select font in "${fonts[@]}"; do
    if [ -n "$font" ]; then
      echo "선택한 폰트: $font"
      return 0
    else
      echo "잘못된 선택입니다. 다시 선택해주세요."
    fi
  done
}

# 폰트 삭제 함수
remove_font() {
  local font_name=$1
  local font_path="${FONT_DIR}/${font_name}"
  if [ -d "${font_path}" ]; then
    echo "Removing ${font_name} Nerd Font..."
    rm -rf "${font_path}"
    fc-cache -f
    echo "Removal complete. ${font_name} Nerd Font has been removed."
  else
    echo "${font_name} Nerd Font is not installed."
  fi
}

# 메인 메뉴
while true; do
  echo -e "\nNerd Font 관리 스크립트"
  echo "1. 폰트 검색 및 설치"
  echo "2. 설치된 폰트 목록 및 삭제"
  echo "3. 종료"
  read -p "선택하세요 (1-3): " choice

  case $choice in
  1)
    if search_and_select_font; then
      install_font "$font"
    fi
    ;;
  2)
    if list_and_select_installed_font; then
      read -p "${font}를 삭제하시겠습니까? (y/n): " confirm
      if [[ $confirm == [Yy]* ]]; then
        remove_font "$font"
      fi
    fi
    ;;
  3)
    echo "스크립트를 종료합니다."
    exit 0
    ;;
  *)
    echo "잘못된 선택입니다. 다시 선택해주세요."
    ;;
  esac
done
