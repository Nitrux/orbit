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

Rectangle {
    width: parent.width
    color: "#eeeeee"
    border.color: "#cccccc"
    height: layout.implicitHeight + 20

    property int maxButtonWidth: 46
    property int spacing: 16
    property var categories: [
        { iconName: "applications-development", category: "Development" },
        { iconName: "applications-education-mathematics", category: "Education" },
        { iconName: "applications-education", category: "Education" },
        { iconName: "applications-games", category: "Games" },
        { iconName: "applications-graphics", category: "Graphics" },
        { iconName: "applications-internet", category: "Internet" },
        { iconName: "applications-multimedia", category: "Multimedia" },
        { iconName: "applications-office", category: "Office" },
        { iconName: "applications-other", category: "Other" },
        { iconName: "applications-system", category: "System" },
        { iconName: "applications-utilities", category: "Utilities" }
    ]

    Column {
        id: layout
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 8

        property int spacing: 12
        property int maxButtonWidth: 46
        property int buttonsPerRow: Math.floor((parent.width * 0.95) / (maxButtonWidth + spacing))
        property int rowCount: Math.ceil(categories.length / buttonsPerRow)

        Repeater {
            model: layout.rowCount

            Row {
                spacing: layout.spacing
                anchors.horizontalCenter: parent.horizontalCenter

                Repeater {
                    model: {
                        const start = index * layout.buttonsPerRow;
                        const end = Math.min(start + layout.buttonsPerRow, categories.length);
                        const sub = [];
                        for (let i = start; i < end; ++i)
                            sub.push(categories[i]);
                        return sub;
                    }

                    delegate: ToolButton {
                        icon.name: modelData.iconName
                        ToolTip.text: modelData.category
                        width: 30
                        height: 30
                        onClicked: console.log("Clicked category:", modelData.category)
                    }
                }
            }
        }
    }
}
