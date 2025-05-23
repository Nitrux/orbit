// #############################################################################################################################################################################
// #   The license used for this file and its contents is: BSD-3-Clause                                                                                                        #
// #                                                                                                                                                                           #
// #   Copyright <2025> <Uri Herrera <uri_herrera@nxos.org>>                                                                                                                   #
// #                                                                                                                                                                           #
// #   Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:                          #
// #                                                                                                                                                                           #
// #    1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.                                        #
// #                                                                                                                                                                           #
// #    2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer                                      #
// #       in the documentation and/or other materials provided with the distribution.                                                                                         #
// #                                                                                                                                                                           #
// #    3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software                    #
// #       without specific prior written permission.                                                                                                                          #
// #                                                                                                                                                                           #
// #    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,                      #
// #    THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS                  #
// #    BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE                 #
// #    GOODS OR SERVICES; LOSS OF USE, DATA,   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,                      #
// #    STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.   #
// #############################################################################################################################################################################

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import AppComponents 1.0

ApplicationWindow {
    id: appWindow
    visible: true
    width: 1024
    height: 768
    title: "Orbit"

    property bool searchVisible: false

    Item {
        anchors.fill: parent

        // Main vertical layout
        Column {
            id: mainColumn
            anchors.fill: parent
            spacing: 0

            TopNavigationBar {
                id: topNav
                width: parent.width
                onToggleSearch: searchVisible = !searchVisible
            }

            CategoryBar {
                id: categoryBar
                width: parent.width
            }

            // Main scrollable content
            ScrollView {
                id: scrollArea
                width: parent.width
                height: parent.height - topNav.height - categoryBar.height

                MainView {
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        // Floating Search Overlay
        Rectangle {
            id: searchOverlay
            width: parent.width
            height: searchVisible ? 56 : 0
            y: topNav.height + categoryBar.height
            color: "#ffffff"
            border.color: "#dcdcdc"
            clip: true
            z: 100

            Behavior on height {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 14
                spacing: 8

                Rectangle {
                    id: searchBox
                    radius: 10
                    color: "#f5f5f5"
                    border.color: "#cccccc"
                    Layout.fillWidth: true
                    height: 30

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 2
                        spacing: 6

                        TextField {
                            id: searchField
                            placeholderText: "Search applications"
                            placeholderTextColor: "#888888"
                            font.pixelSize: 14
                            color: "#333333"
                            background: null
                            verticalAlignment: Text.AlignVCenter
                            Layout.fillWidth: true
                            height: parent.height
                        }

                        ToolButton {
                            icon.name: "edit-find"
                            background: null
                            Layout.alignment: Qt.AlignVCenter
                            height: parent.height
                            onClicked: AppHub.search_app(searchField.text)
                        }
                    }
                }
            }
        }
    }
}
