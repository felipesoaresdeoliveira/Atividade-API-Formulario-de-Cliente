<# : batch portion
@REM Apache Maven Wrapper startup batch script, version 3.3.4
@IF "%__MVNW_ARG0_NAME__%"=="" (SET __MVNW_ARG0_NAME__=%~nx0)
@SET __MVNW_CMD__=
@SET __MVNW_PSMODULEP_SAVE=%PSModulePath%
@SET PSModulePath=
@FOR /F "usebackq tokens=1* delims==" %%A IN (`powershell -noprofile "& {$scriptDir='%~dp0'; $script='%__MVNW_ARG0_NAME__%'; icm -ScriptBlock ([Scriptblock]::Create((Get-Content -Raw '%~f0'))) -NoNewScope}"`) DO @(
  IF "%%A"=="MVN_CMD" (set __MVNW_CMD__=%%B) ELSE IF "%%B"=="" (echo %%A) ELSE (echo %%A=%%B)
)
@SET PSModulePath=%__MVNW_PSMODULEP_SAVE%
@SET __MVNW_PSMODULEP_SAVE=
@SET __MVNW_ARG0_NAME__=
@SET MVNW_USERNAME=
@SET MVNW_PASSWORD=
@IF NOT "%__MVNW_CMD__%"=="" ("%__MVNW_CMD__%" %*)
@echo Cannot start maven from wrapper >&2 && exit /b 1
@GOTO :EOF
: end batch / begin powershell #>

$ErrorActionPreference = "Stop"
$distributionUrl = (Get-Content -Raw "$scriptDir/.mvn/wrapper/maven-wrapper.properties" | ConvertFrom-StringData).distributionUrl
if (!$distributionUrl) { Write-Error "cannot read distributionUrl" }
$distributionUrlName = $distributionUrl -replace '^.*/',''
$distributionUrlNameMain = $distributionUrlName -replace '\.[^.]*$','' -replace '-bin$',''
$MAVEN_M2_PATH = if ($env:MAVEN_USER_HOME) { $env:MAVEN_USER_HOME } else { "$HOME/.m2" }
if (-not (Test-Path $MAVEN_M2_PATH)) { New-Item -Path $MAVEN_M2_PATH -ItemType Directory | Out-Null }
$hash = ([System.Security.Cryptography.SHA256]::Create().ComputeHash([byte[]][char[]]$distributionUrl) | ForEach-Object {$_.ToString("x2")}) -join ''
$MAVEN_HOME_PARENT = "$MAVEN_M2_PATH/wrapper/dists/$distributionUrlNameMain"
$MAVEN_HOME = "$MAVEN_HOME_PARENT/$hash"
$MVN_CMD = "mvn.cmd"
if (-not (Test-Path "$MAVEN_HOME/bin/$MVN_CMD")) {
  $tmp = Join-Path ([System.IO.Path]::GetTempPath()) ([System.Guid]::NewGuid().ToString())
  New-Item -ItemType Directory -Path $tmp | Out-Null
  New-Item -ItemType Directory -Path $MAVEN_HOME_PARENT -Force | Out-Null
  $zip = Join-Path $tmp $distributionUrlName
  (New-Object System.Net.WebClient).DownloadFile($distributionUrl, $zip)
  Expand-Archive $zip -DestinationPath $tmp
  $extracted = Get-ChildItem $tmp -Directory | Where-Object { Test-Path (Join-Path $_.FullName "bin/$MVN_CMD") } | Select-Object -First 1
  if (!$extracted) { Write-Error "Maven distribution not found after extraction" }
  if (-not (Test-Path $MAVEN_HOME)) { Move-Item $extracted.FullName $MAVEN_HOME }
  Remove-Item $tmp -Recurse -Force
}
Write-Output "MVN_CMD=$MAVEN_HOME/bin/$MVN_CMD"
