def export_rows(rows):
    return [row for row in rows if row["return_bps"] is not None]
