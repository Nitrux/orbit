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
    anchors.fill: parent
    color: "#ffffff"

    Flickable {
        id: scrollArea
        anchors.fill: parent
        contentWidth: width
        contentHeight: mainColumn.implicitHeight
        clip: true

        Column {
            id: mainColumn
            width: scrollArea.width * 0.9
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 18

            // Spacer
            Rectangle {
                height: 12
                width: parent.width
                color: "transparent"
            }

            // Carousel Banner
            SwipeView {
                id: bannerView
                width: mainColumn.width
                height: 300
                currentIndex: 0
                clip: true
                anchors.horizontalCenter: parent.horizontalCenter

                Repeater {
                    model: ListModel {
                        ListElement {
                            title: "Lorem ipsum"
                            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                            bgcolor: "#f5b041"
                        }
                        ListElement {
                            title: "Dolor sit amet"
                            description: "Etiam vel lorem eget justo."
                            bgcolor: "#bb8fce"
                        }
                        ListElement {
                            title: "Consectetur elit"
                            description: "Donec in magna id nulla porttitor convallis."
                            bgcolor: "#ec7063"
                        }
                    }

                    delegate: Rectangle {
                        width: bannerView.width
                        height: bannerView.height
                        color: bgcolor

                        // Carousel text in lower-left
                        Column {
                            anchors.left: parent.left
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: bannerView.width * 0.05
                            anchors.bottomMargin: 24
                            spacing: 8

                            Text {
                                text: title
                                color: "white"
                                font.pixelSize: 20
                                font.bold: true
                            }

                            Text {
                                text: description
                                color: "white"
                                font.pixelSize: 14
                                wrapMode: Text.Wrap
                                width: bannerView.width * 0.6
                            }
                        }

                        // Carousel icon on middle-right
                        Image {
                            source: "file:/usr/share/icons/breeze/apps/48/system-file-manager.svg"
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.rightMargin: bannerView.width * 0.05
                            width: 96
                            height: 96
                            fillMode: Image.PreserveAspectFit
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
            Column {
                id: cardColumn
                width: mainColumn.width
                spacing: 16
                anchors.horizontalCenter: parent.horizontalCenter

                property int cardsPerRow: Math.floor(width / 240)
                property int totalCards: 20
                property int rowCount: Math.ceil(totalCards / cardsPerRow)

                Repeater {
                    model: cardColumn.rowCount

                    Row {
                        spacing: 16
                        anchors.horizontalCenter: parent.horizontalCenter

                        Repeater {
                            model: {
                                const cards = [];
                                const start = index * cardColumn.cardsPerRow;
                                const end = Math.min(start + cardColumn.cardsPerRow, cardColumn.totalCards);
                                for (let i = start; i < end; ++i)
                                    cards.push(i);
                                return cards;
                            }

                            delegate: Rectangle {
                                width: 220
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
                                        color: "#f5f5f5"
                                        anchors.horizontalCenter: parent.horizontalCenter

                                        Image {
                                            anchors.centerIn: parent
                                            source: "file:/usr/share/icons/breeze/apps/48/system-file-manager.svg"
                                            width: 64
                                            height: 64
                                            fillMode: Image.PreserveAspectFit
                                        }
                                    }

                                    Text {
                                        text: "Lorem ipsum"
                                        font.bold: true
                                        font.pixelSize: 14
                                        horizontalAlignment: Text.AlignHCenter
                                        width: parent.width
                                    }

                                    Text {
                                        text: "Lorem ipsum dolor sit amet"
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

        ScrollBar.vertical: ScrollBar { }
    }
}
