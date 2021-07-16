package main

import (
	"encoding/csv"
	"fmt"
	"log"
	"os"

	"github.com/360EntSecGroup-Skylar/excelize"
)

func main() {
	if len(os.Args) == 0 {
		fmt.Printf(`Usage:
xlsx2csv a.xlsx b.xlsx
`)
		os.Exit(1)
	}

	for _, filename := range os.Args[1:] {
		f, err := excelize.OpenFile(filename)
		if err != nil {
			fmt.Println(err)
			return
		}

		sheets := f.GetSheetMap()
		for _, sheet := range sheets {
			out, err := os.Create(sheet + ".csv")
			if err != nil {
				log.Fatal(err)
			}

			cw := csv.NewWriter(out)
			rows := f.GetRows(sheet)
			for _, row := range rows {
				err := cw.Write(row)
				if err != nil {
					log.Fatal(err)
				}
			}

			cw.Flush()
		}
	}
}
