CPPFLAGS="${CPPFLAGS:-} -I${PWD}/src/include"
CFLAGS="${CFLAGS:-} -ffunction-sections -fdata-sections"
LDFLAGS="-L${DEST}/lib -L${DEPS}/lib -Wl,--gc-sections"

### LIBXML2 ###
_build_libxml2() {
local VERSION="2.9.2"
local FOLDER="libxml2-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="ftp://xmlsoft.org/libxml2/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="${DEST}" --without-zlib --without-lzma --without-python --disable-shared
make
make install
"${STRIP}" -s -R .comment -R .note -R .note.ABI-tag "${DEST}/bin/xmllint"
popd
}

_build_rootfs() {
# /usr/bin/xmllint
  return 0
}

_build() {
  _build_incron
  _package
}
