{ config, pkgs, lib, ... }:

let
  qmlPackages = with pkgs.kdePackages; [
    plasma-workspace
    libplasma
    kirigami
    kirigami-addons
    ksvg
    knewstuff
    kcoreaddons
    kconfig
    kguiaddons
    ki18n
    kiconthemes
    kwindowsystem
    knotifications
    qqc2-breeze-style
    qqc2-desktop-style
    sonnet
    kcmutils
    kdeclarative
    kitemmodels
    kquickcharts
    layer-shell-qt
  ];
  qmlPath = lib.makeSearchPathOutput "lib" "lib/qt-6/qml" qmlPackages;
in
{
  services.desktopManager.plasma6.enable = true;
  environment.systemPackages = qmlPackages ++ (with pkgs; [
    libsForQt5.qt5ct
    kdePackages.qt6ct
    adwaita-qt
  ]);

  environment.sessionVariables = {
    QML2_IMPORT_PATH = qmlPath;
    QML_IMPORT_PATH = qmlPath;
  };
}