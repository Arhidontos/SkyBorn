# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'C:/git/ModOrganizer2/mob/zBuild/build/modorganizer_super/installer_wizard/src/ui/wizardinstallercomplete.ui'
#
# Created by: PyQt5 UI code generator 5.15.2
#
# WARNING: Any manual changes made to this file will be lost when pyuic5 is
# run again.  Do not edit this file unless you know what you are doing.


from PyQt5 import QtCore, QtGui, QtWidgets


class Ui_WizardInstallerComplete(object):
    def setupUi(self, WizardInstallerComplete):
        WizardInstallerComplete.setObjectName("WizardInstallerComplete")
        WizardInstallerComplete.resize(652, 476)
        WizardInstallerComplete.setWindowTitle("")
        self.verticalLayout_2 = QtWidgets.QVBoxLayout(WizardInstallerComplete)
        self.verticalLayout_2.setContentsMargins(0, 0, 0, 0)
        self.verticalLayout_2.setObjectName("verticalLayout_2")
        self.verticalLayout = QtWidgets.QVBoxLayout()
        self.verticalLayout.setObjectName("verticalLayout")
        self.label = QtWidgets.QLabel(WizardInstallerComplete)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Preferred)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.label.sizePolicy().hasHeightForWidth())
        self.label.setSizePolicy(sizePolicy)
        self.label.setObjectName("label")
        self.verticalLayout.addWidget(self.label)
        self.widget = QtWidgets.QWidget(WizardInstallerComplete)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Preferred)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.widget.sizePolicy().hasHeightForWidth())
        self.widget.setSizePolicy(sizePolicy)
        self.widget.setMinimumSize(QtCore.QSize(0, 0))
        self.widget.setObjectName("widget")
        self.verticalLayout_11 = QtWidgets.QVBoxLayout(self.widget)
        self.verticalLayout_11.setContentsMargins(0, 0, 0, 0)
        self.verticalLayout_11.setObjectName("verticalLayout_11")
        self.splitter = QtWidgets.QSplitter(self.widget)
        self.splitter.setOrientation(QtCore.Qt.Vertical)
        self.splitter.setObjectName("splitter")
        self.packagesWidget = QtWidgets.QWidget(self.splitter)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Preferred)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(15)
        sizePolicy.setHeightForWidth(self.packagesWidget.sizePolicy().hasHeightForWidth())
        self.packagesWidget.setSizePolicy(sizePolicy)
        self.packagesWidget.setMinimumSize(QtCore.QSize(0, 0))
        self.packagesWidget.setObjectName("packagesWidget")
        self.verticalLayout_9 = QtWidgets.QVBoxLayout(self.packagesWidget)
        self.verticalLayout_9.setContentsMargins(0, 0, 0, 0)
        self.verticalLayout_9.setObjectName("verticalLayout_9")
        self.verticalLayout_5 = QtWidgets.QVBoxLayout()
        self.verticalLayout_5.setObjectName("verticalLayout_5")
        self.horizontalLayout = QtWidgets.QHBoxLayout()
        self.horizontalLayout.setObjectName("horizontalLayout")
        self.verticalLayout_3 = QtWidgets.QVBoxLayout()
        self.verticalLayout_3.setObjectName("verticalLayout_3")
        self.label_2 = QtWidgets.QLabel(self.packagesWidget)
        self.label_2.setProperty("heading", True)
        self.label_2.setObjectName("label_2")
        self.verticalLayout_3.addWidget(self.label_2)
        self.subpackagesList = QtWidgets.QListWidget(self.packagesWidget)
        self.subpackagesList.setObjectName("subpackagesList")
        self.verticalLayout_3.addWidget(self.subpackagesList)
        self.horizontalLayout.addLayout(self.verticalLayout_3)
        self.verticalLayout_4 = QtWidgets.QVBoxLayout()
        self.verticalLayout_4.setObjectName("verticalLayout_4")
        self.label_3 = QtWidgets.QLabel(self.packagesWidget)
        self.label_3.setProperty("heading", True)
        self.label_3.setObjectName("label_3")
        self.verticalLayout_4.addWidget(self.label_3)
        self.pluginsList = QtWidgets.QListWidget(self.packagesWidget)
        self.pluginsList.setObjectName("pluginsList")
        self.verticalLayout_4.addWidget(self.pluginsList)
        self.horizontalLayout.addLayout(self.verticalLayout_4)
        self.verticalLayout_5.addLayout(self.horizontalLayout)
        self.verticalLayout_9.addLayout(self.verticalLayout_5)
        self.tweaksWidget = QtWidgets.QWidget(self.splitter)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Preferred)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(10)
        sizePolicy.setHeightForWidth(self.tweaksWidget.sizePolicy().hasHeightForWidth())
        self.tweaksWidget.setSizePolicy(sizePolicy)
        self.tweaksWidget.setObjectName("tweaksWidget")
        self.verticalLayout_7 = QtWidgets.QVBoxLayout(self.tweaksWidget)
        self.verticalLayout_7.setContentsMargins(0, 0, 0, 0)
        self.verticalLayout_7.setObjectName("verticalLayout_7")
        self.verticalLayout_6 = QtWidgets.QVBoxLayout()
        self.verticalLayout_6.setObjectName("verticalLayout_6")
        self.tweaksLabel = QtWidgets.QLabel(self.tweaksWidget)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Minimum)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.tweaksLabel.sizePolicy().hasHeightForWidth())
        self.tweaksLabel.setSizePolicy(sizePolicy)
        self.tweaksLabel.setLineWidth(0)
        self.tweaksLabel.setProperty("heading", True)
        self.tweaksLabel.setObjectName("tweaksLabel")
        self.verticalLayout_6.addWidget(self.tweaksLabel)
        self.tweaksLayout = QtWidgets.QHBoxLayout()
        self.tweaksLayout.setObjectName("tweaksLayout")
        self.tweaksList = QtWidgets.QListWidget(self.tweaksWidget)
        self.tweaksList.setObjectName("tweaksList")
        self.tweaksLayout.addWidget(self.tweaksList)
        self.tweaksTextEdit = QtWidgets.QPlainTextEdit(self.tweaksWidget)
        self.tweaksTextEdit.setReadOnly(True)
        self.tweaksTextEdit.setObjectName("tweaksTextEdit")
        self.tweaksLayout.addWidget(self.tweaksTextEdit)
        self.verticalLayout_6.addLayout(self.tweaksLayout)
        self.verticalLayout_7.addLayout(self.verticalLayout_6)
        self.notesWidget = QtWidgets.QWidget(self.splitter)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Preferred)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(10)
        sizePolicy.setHeightForWidth(self.notesWidget.sizePolicy().hasHeightForWidth())
        self.notesWidget.setSizePolicy(sizePolicy)
        self.notesWidget.setMinimumSize(QtCore.QSize(0, 0))
        self.notesWidget.setObjectName("notesWidget")
        self.verticalLayout_10 = QtWidgets.QVBoxLayout(self.notesWidget)
        self.verticalLayout_10.setContentsMargins(0, 0, 0, 0)
        self.verticalLayout_10.setObjectName("verticalLayout_10")
        self.verticalLayout_8 = QtWidgets.QVBoxLayout()
        self.verticalLayout_8.setObjectName("verticalLayout_8")
        self.notesLabel = QtWidgets.QLabel(self.notesWidget)
        self.notesLabel.setProperty("heading", True)
        self.notesLabel.setObjectName("notesLabel")
        self.verticalLayout_8.addWidget(self.notesLabel)
        self.notesTextEdit = QtWidgets.QTextEdit(self.notesWidget)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Expanding)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.notesTextEdit.sizePolicy().hasHeightForWidth())
        self.notesTextEdit.setSizePolicy(sizePolicy)
        self.notesTextEdit.setReadOnly(True)
        self.notesTextEdit.setObjectName("notesTextEdit")
        self.verticalLayout_8.addWidget(self.notesTextEdit)
        self.verticalLayout_10.addLayout(self.verticalLayout_8)
        self.verticalLayout_11.addWidget(self.splitter)
        self.verticalLayout.addWidget(self.widget)
        self.verticalLayout_2.addLayout(self.verticalLayout)

        self.retranslateUi(WizardInstallerComplete)
        QtCore.QMetaObject.connectSlotsByName(WizardInstallerComplete)

    def retranslateUi(self, WizardInstallerComplete):
        _translate = QtCore.QCoreApplication.translate
        self.label.setText(_translate("WizardInstallerComplete", "The installer script has finished. The following sub-packages and plugins will be installed."))
        self.label_2.setText(_translate("WizardInstallerComplete", "Sub-Packages:"))
        self.label_3.setText(_translate("WizardInstallerComplete", "Plugins:"))
        self.tweaksLabel.setText(_translate("WizardInstallerComplete", "INI Tweaks:"))
        self.notesLabel.setText(_translate("WizardInstallerComplete", "Notes:"))
