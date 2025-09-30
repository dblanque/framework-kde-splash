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

		Image {
			id: logo
			readonly property real size: Kirigami.Units.gridUnit * 6
			anchors.centerIn: parent
			asynchronous: true
			source: "images/framework-wordmark.svgz"
			// The fillMode will preserve aspect ratio and fit within these bounds
			fillMode: Image.PreserveAspectFit
			sourceSize.height: size
			sourceSize.width: size
		}

		// spin the framework cog
		Image {
			id: busyIndicator
			// Position in the middle of the remaining space below the logo
			y: parent.height - (parent.height - logo.y) / 2 - height/2
			anchors.horizontalCenter: parent.horizontalCenter
			asynchronous: true
			source: "images/framework-icon.svgz"
			sourceSize.height: Kirigami.Units.gridUnit * 2
			sourceSize.width: Kirigami.Units.gridUnit * 2
			RotationAnimator on rotation {
				id: rotationAnimator
				from: 0
				to: 360
				// Not using a standard duration value because we don't want the
				// animation to spin faster or slower based on the user's animation
				// scaling preferences; it doesn't make sense in this context
				duration: 2000
				loops: Animation.Infinite
				// Don't want it to animate at all if the user has disabled animations
				running: Kirigami.Units.longDuration > 1
			}
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
