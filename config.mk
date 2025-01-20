CONFIG_ROOT!=		git rev-parse --show-toplevel
CONFIG_ROOT:=		${CONFIG_ROOT:C,/$,,}
CONFIG_ROOT_NAME:=	${CONFIG_ROOT:C,^.*/([^/]+)$,\1,}

RELATIVE_CURDIR=	${.CURDIR:C,^${CONFIG_ROOT}/*,,}

ALL_MACS!=	ifconfig | grep ether | cut -d' ' -f2
.for mac in ${ALL_MACS}
mac_config=		servers/${mac:C/\:/-/g}.mk
.if exists(${mac_config})
MAC:=			${mac}
MAC_CONFIG:=	${mac_config}
.endif
.endfor

.if !defined(MAC) || empty(MAC)
.error Unable to locate this machine's MAC address in the site-wide configuration repository. Please ensure that the machine's configuration as been committed and try again.
.endif

OS!=	uname -s | tr '[A-Z]' '[a-z]'

.include "./${MAC_CONFIG}"

all: sysinfo

sysinfo:
	@echo ===> System information for ${MAC}
	@echo   ===> Hostname: ${HOSTNAME}.${SITE}.${ROOT_DOMAIN}
	@echo   ===> IP Address: ${IP}
	@echo   ===> Roles: ${ROLES}