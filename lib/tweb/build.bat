@echo off
@cls
@set path=c:\harbour\bin
@set include=c:\harbour\include

@echo ===========================================
@echo Building TWeb ( GUI Bootstrap for Harbour )
@echo ===========================================

harbour tweb.prg /n /w /gh

pause
