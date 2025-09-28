/*
	SPDX-FileCopyrightText: 2025 Dylan Blanque <dylan@blanque.com.ar>

	SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick
import org.kde.kirigami 2 as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents3

Rectangle {
	id: root
	color: "black"

	property int stage

	onStageChanged: {
		if (stage == 2) {
			introAnimation.running = true;
		} else if (stage == 5) {
			introAnimation.target = busyIndicator;
			introAnimation.from = 1;
			introAnimation.to = 0;
			introAnimation.running = true;
		}
	}

	Item {
		id: content
		anchors.fill: parent
		opacity: 0

		// KDE's built-in busy indicator
		PlasmaComponents3.BusyIndicator {
			id: busyIndicator
			// Position in the middle of the remaining space below the logo
			y: parent.height - (parent.height - logo.y) / 2
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			width: Kirigami.Units.gridUnit * 3
			height: Kirigami.Units.gridUnit * 3
			// running: true (enabled by default)
		}
	}

	OpacityAnimator {
		id: introAnimation
		running: false
		target: content
		from: 0
		to: 1
		duration: Kirigami.Units.veryLongDuration * 2
		easing.type: Easing.InOutQuad
	}
}
