# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit meson gnome2-utils xdg

DESCRIPTION="Cinnamon's settings daemon"
HOMEPAGE="https://projects.linuxmint.com/cinnamon/"
SRC_URI="https://github.com/linuxmint/cinnamon-settings-daemon/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +colord cups input_devices_wacom smartcard systemd"
RESTRICT="test"

# udev is non-optional since lots of plugins, not just gudev, pull it in
RDEPEND="
	>=dev-libs/glib-2.38:2
	dev-libs/libgudev:=
	>=gnome-base/libgnomekbd-3.6
	>=gnome-extra/cinnamon-desktop-4.8:0=
	media-libs/fontconfig
	>=media-libs/lcms-2.2:2
	media-libs/libcanberra:0=[gtk3]
	media-sound/pulseaudio[glib]
	>=sys-apps/dbus-1.1.2
	dev-libs/dbus-glib
	>=sys-auth/polkit-0.97
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.9.10:3
	>=x11-libs/libnotify-0.7.3:0=
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	>=x11-libs/libxklavier-5.0
	>=sys-power/upower-0.9.11

	colord? ( >=x11-misc/colord-0.1.27:= )
	cups? (
		>=net-print/cups-1.4[dbus]
		app-admin/system-config-printer
		net-print/cups-pk-helper )
	input_devices_wacom? (
		>=dev-libs/libwacom-0.7
		>=gnome-base/librsvg-2.36.2
		x11-drivers/xf86-input-wacom
		x11-libs/libXtst )
	smartcard? ( >=dev-libs/nss-3.11.2 )
	systemd? ( sys-apps/systemd:0= )
	!systemd? ( sys-auth/elogind:0= )
"
DEPEND="${RDEPEND}
	dev-libs/libxml2:2
	x11-base/xorg-proto
"
BDEPEND="
	dev-util/glib-utils
	dev-util/gdbus-codegen
	>=dev-util/intltool-0.37.1
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		-Duse_gudev=enabled
		-Duse_logind=enabled
		-Duse_polkit=enabled
		$(meson_use colord use_color)
		$(meson_feature cups use_cups)
		$(meson_use debug enable_debug)
		$(meson_feature smartcard enable_smartcard)
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
