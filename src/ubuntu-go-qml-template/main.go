package main

import (
        "gopkg.in/qml.v1"
        "log"
)

func main() {
        err := qml.Run(run)
        if (err != nil) {
                log.Fatal(err)
        }
}

func run() error {
        engine := qml.NewEngine()
        component, err := engine.LoadFile("share/ubuntu-go-qml-template/main.qml")
        if err != nil {
                return err
        }

        ctrl := Control{Message: "Hello from Go!"}
        context := engine.Context()
        context.SetVar("ctrl", &ctrl)

        win := component.CreateWindow(nil)
        ctrl.Root = win.Root()

        win.Show()
        win.Wait()
        return nil
}

type Control struct {
	Root    qml.Object
	Message string
}

func (ctrl *Control) Hello() {
        go func() {
                if (ctrl.Message == "Hello from Go!") {
                        ctrl.Message = "Hello from Go Again!"
                } else {
                        ctrl.Message = "Hello from Go!"
                }
                qml.Changed(ctrl, &ctrl.Message)
        }()
}

