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
    height: 41
    color: "#eeeeee"
    border.color: "#cccccc"

    Row {
        anchors.centerIn: parent
        spacing: 16

        Repeater {
            model: ListModel {
                ListElement { iconName: "applications-development"; category: "Development" }
                ListElement { iconName: "applications-education-mathematics"; category: "Education" }
                ListElement { iconName: "applications-education"; category: "Education" }
                ListElement { iconName: "applications-games"; category: "Games" }
                ListElement { iconName: "applications-graphics"; category: "Graphics" }
                ListElement { iconName: "applications-internet"; category: "Internet" }
                ListElement { iconName: "applications-multimedia"; category: "Multimedia" }
                ListElement { iconName: "applications-office"; category: "Office" }
                ListElement { iconName: "applications-other"; category: "Other" }
                ListElement { iconName: "applications-system"; category: "System" }
                ListElement { iconName: "appications-utilities"; category: "Utilities" }
            }

            ToolButton {
                icon.name: model.iconName
                ToolTip.text: model.category
                onClicked: console.log("Clicked category:", model.category)
                width: 30
                height: 30
            }
        }
    }
}
