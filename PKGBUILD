# Maintainer: Zilibobka-S
pkgname=zyd
pkgver=0.3
pkgrel=1
pkgdesc="Bash script to open youtube videos using terminal. Uses yt-dlp and mpv"
arch=('any')
url="https://example.com/myscript"
license=('MIT') # Change this to the appropriate license for your script
depends=('bash' 'yt-dlp' 'mpv') # Add dependencies if needed
source=("zyd.sh")
sha256sums=('SKIP') # Replace 'SKIP' with a checksum if needed

package() {
    install -Dm755 "$srcdir/zyd.sh" "$pkgdir/usr/bin/zyd"
}

