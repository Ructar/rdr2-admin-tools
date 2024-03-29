fx_version 'adamant'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

dependency 'ghmattimysql'

version '1.0.0'
author 'Kole'
description 'Handles Admin Tools'

ui_page('ui/dist/index.html')

files { 
	"ui/dist/index.html",
	"ui/dist/**/*.css",
	"ui/dist/**/*.woff",
	"ui/dist/**/*.js",
	"ui/dist/**/*.js.map",
}

client_script 'cl_admin.lua'