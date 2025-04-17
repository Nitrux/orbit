#!/usr/bin/env python3

#############################################################################################################################################################################
#   The license used for this file and its contents is: BSD-3-Clause                                                                                                        #
#                                                                                                                                                                           #
#   Copyright <2025> <Uri Herrera <uri_herrera@nxos.org>>                                                                                                                   #
#                                                                                                                                                                           #
#   Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:                          #
#                                                                                                                                                                           #
#    1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.                                        #
#                                                                                                                                                                           #
#    2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer                                      #
#       in the documentation and/or other materials provided with the distribution.                                                                                         #
#                                                                                                                                                                           #
#    3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software                    #
#       without specific prior written permission.                                                                                                                          #
#                                                                                                                                                                           #
#    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,                      #
#    THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS                  #
#    BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE                 #
#    GOODS OR SERVICES; LOSS OF USE, DATA,   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,                      #
#    STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.   #
#############################################################################################################################################################################

import sys
from pathlib import Path
from PySide6.QtCore import QUrl, QObject, Slot, QAbstractListModel, Qt, QModelIndex
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine

from nx_apphub_cli.manager import get_search_results


class AppListModel(QAbstractListModel):
    NAME_ROLE = Qt.UserRole + 1
    VERSION_ROLE = Qt.UserRole + 2
    ARCH_ROLE = Qt.UserRole + 3

    def __init__(self, apps=None):
        super().__init__()
        self._apps = apps or []

    def data(self, index, role):
        if not index.isValid():
            return None

        app = self._apps[index.row()]

        if role == self.NAME_ROLE:
            return app.get("name")
        elif role == self.VERSION_ROLE:
            return app.get("version")
        elif role == self.ARCH_ROLE:
            return app.get("arch")

        return None

    def roleNames(self):
        return {
            self.NAME_ROLE: b"name",
            self.VERSION_ROLE: b"version",
            self.ARCH_ROLE: b"arch"
        }

    def rowCount(self, parent=QModelIndex()):
        return len(self._apps)

    def update(self, new_list):
        self.beginResetModel()
        self._apps = new_list
        self.endResetModel()


class AppHubBackend(QObject):
    def __init__(self, model):
        super().__init__()
        self.model = model

    @Slot(str)
    def search_app(self, app_name):
        result_dicts = get_search_results([app_name])
        self.model.update(result_dicts)

    @Slot(str)
    def install_app(self, app_name):
        print(f"Installing {app_name}...")

if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    app_model = AppListModel()
    backend = AppHubBackend(app_model)

    engine.rootContext().setContextProperty("AppHub", backend)
    engine.rootContext().setContextProperty("appListModel", app_model)

    qml_file = Path(__file__).resolve().parent / "main.qml"
    qml_import_path = Path(__file__).resolve().parent / "qml"
    engine.addImportPath(str(qml_import_path))

    # -- Add QML import path BEFORE loading the file.

    engine.addImportPath(str(qml_import_path))
    print(f"📁 Added QML import path: {qml_import_path}")

    print(f"📄 Loading QML: {qml_file}")
    engine.load(QUrl.fromLocalFile(str(qml_file)))

    if not engine.rootObjects():
        sys.exit(-1)
    else:
        print("✅ GUI loaded successfully")

    sys.exit(app.exec())
