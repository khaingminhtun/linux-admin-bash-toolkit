package internal

import (
	"fmt"
	"os"
	"os/exec"
)

func RunScript(script string, args []string) {
	cmd := exec.Command(script, args...)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	err := cmd.Run()
	if err != nil {
		fmt.Println("Error executing:", script)
		os.Exit(1)
	}
}
