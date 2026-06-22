package main

import (
	"fmt"
	"ftool/internal"
	"os"
)

func main() {

	if len(os.Args) < 2 {
		fmt.Println("Usage: ftool <command>")
		return
	}

	command := os.Args[1]

	switch command {

	case "backup":
		internal.RunScript("./scripts/backup.sh", os.Args[2:])

	case "organize":
		internal.RunScript("./scripts/organize.sh", os.Args[2:])

	case "cleanup":
		internal.RunScript("./scripts/cleanup.sh", os.Args[2:])

	case "search":
		internal.RunScript("./scripts/search.sh", os.Args[2:])

	case "disk":
		internal.RunScript("./scripts/disk_usage.sh", os.Args[2:])

	default:
		fmt.Println("Unknown command:", command)
	}
}
