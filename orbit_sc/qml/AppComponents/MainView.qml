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

Rectangle {
    width: parent.width
    anchors.fill: parent
    color: "#ffffff" // Visible background

    Column {
        id: mainColumn
        width: parent.width
        spacing: 20
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle {
            height: 24
            width: parent.width
            color: "transparent"
        }

        // Carousel Banner
        SwipeView {
            id: bannerView
            width: mainColumn.width * 0.9
            height: 200
            currentIndex: 0
            clip: true
            anchors.horizontalCenter: parent.horizontalCenter

            Repeater {
                model: ListModel {
                    ListElement { title: "Lorem ipsum"; description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit." }
                    ListElement { title: "Dolor sit amet"; description: "Etiam vel lorem eget justo." }
                    ListElement { title: "Consectetur elit"; description: "Donec in magna id nulla porttitor convallis." }
                }

                delegate: Rectangle {
                    width: bannerView.width
                    height: bannerView.height
                    color: "#222"

                    Column {
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 8

                        Text {
                            text: title
                            color: "white"
                            font.pixelSize: 20
                            font.bold: true
                        }

                        Text {
                            text: description
                            color: "#ccc"
                            font.pixelSize: 14
                            wrapMode: Text.Wrap
                            width: bannerView.width * 0.6
                        }
                    }
                }
            }
        }

        // Pagination Dots
        Row {
            spacing: 8
            anchors.horizontalCenter: parent.horizontalCenter

            Repeater {
                model: bannerView.count

                Rectangle {
                    width: 8
                    height: 8
                    radius: 4
                    color: index === bannerView.currentIndex ? "black" : "#ccc"
                }
            }
        }

        // Application Cards
        RowLayout {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter

            GridLayout {
                id: cardGrid
                columns: 3
                columnSpacing: 16
                rowSpacing: 16
                Layout.alignment: Qt.AlignHCenter

                Repeater {
                    model: ListModel {
                        ListElement { name: "Lorem ipsum"; description: "Lorem ipsum dolor sit amet"; icon: "system-file-manager" }
                        ListElement { name: "Lorem ipsum"; description: "Lorem ipsum dolor sit amet"; icon: "preferences-system" }
                        ListElement { name: "Lorem ipsum"; description: "Lorem ipsum dolor sit amet"; icon: "utilities-text-editor" }
                    }

                    delegate: Rectangle {
                        width: 200
                        height: 180
                        radius: 8
                        border.color: "#ddd"
                        color: "#f5f5f5"

                        Column {
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 10

                            Rectangle {
                                width: 64
                                height: 64
                                radius: 8
                                color: "#ffe082"
                                anchors.horizontalCenter: parent.horizontalCenter

                                Image {
                                    anchors.centerIn: parent
                                    source: "image://icon/" + icon
                                    width: 32
                                    height: 32
                                }
                            }

                            Text {
                                text: name
                                font.bold: true
                                font.pixelSize: 14
                                horizontalAlignment: Text.AlignHCenter
                                width: parent.width
                            }

                            Text {
                                text: description
                                font.pixelSize: 12
                                color: "#666"
                                horizontalAlignment: Text.AlignHCenter
                                width: parent.width
                                wrapMode: Text.WordWrap
                            }
                        }
                    }
                }
            }
        }
    }
}
