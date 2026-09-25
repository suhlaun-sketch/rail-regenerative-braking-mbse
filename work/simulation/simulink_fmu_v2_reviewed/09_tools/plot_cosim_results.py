#!/usr/bin/env python3
"""Create PNG and vector PDF plots from the actual 16-FMU result CSV."""

from __future__ import annotations

import csv
import math
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfgen import canvas


ROOT = Path(__file__).resolve().parents[4]
RESULTS = ROOT / "work" / "simulation" / "simulink_fmu_v1" / "07_results"
CSV = RESULTS / "Rail_MBSE_All16_FMU_CoSimulation_Results.csv"
OUT = RESULTS / "fmu_cosim_plots"
WIDTH, HEIGHT = 1600, 900
MARGIN = (150, 80, 70, 120)  # left, top, right, bottom
COLORS = [(0, 93, 170), (215, 70, 35), (28, 135, 75)]
FONT_PATH = Path(r"C:\Windows\Fonts\arial.ttf")


def font(size):
    try:
        return ImageFont.truetype(str(FONT_PATH), size)
    except OSError:
        return ImageFont.load_default()


def nice_range(values):
    lo, hi = min(values), max(values)
    if math.isclose(lo, hi):
        pad = max(1.0, abs(lo) * 0.1)
        return lo - pad, hi + pad
    pad = 0.08 * (hi - lo)
    return min(0.0, lo - pad), hi + pad


def transform(x, y, xmin, xmax, ymin, ymax, box):
    left, top, right, bottom = box
    px = left + (x - xmin) / (xmax - xmin) * (right - left)
    py = bottom - (y - ymin) / (ymax - ymin) * (bottom - top)
    return px, py


def draw_png(base, title, ylabel, time_values, series):
    image = Image.new("RGB", (WIDTH, HEIGHT), "white")
    d = ImageDraw.Draw(image)
    left, top = MARGIN[0], MARGIN[1]
    right, bottom = WIDTH - MARGIN[2], HEIGHT - MARGIN[3]
    box = (left, top, right, bottom)
    all_y = [v for _, values in series for v in values]
    ymin, ymax = nice_range(all_y)
    xmin, xmax = 0.0, 50.0
    grid = (220, 225, 230)
    axis = (45, 50, 55)
    for i in range(11):
        x = xmin + (xmax - xmin) * i / 10
        px, _ = transform(x, ymin, xmin, xmax, ymin, ymax, box)
        d.line((px, top, px, bottom), fill=grid, width=1)
        label = f"{x:.0f}"
        d.text((px - 12, bottom + 14), label, fill=axis, font=font(22))
    for i in range(7):
        y = ymin + (ymax - ymin) * i / 6
        _, py = transform(xmin, y, xmin, xmax, ymin, ymax, box)
        d.line((left, py, right, py), fill=grid, width=1)
        label = f"{y:.1f}" if abs(ymax - ymin) < 20 else f"{y:.0f}"
        d.text((left - 105, py - 13), label, fill=axis, font=font(22))
    d.line((left, top, left, bottom), fill=axis, width=3)
    d.line((left, bottom, right, bottom), fill=axis, width=3)
    for idx, (name, values) in enumerate(series):
        points = [transform(x, y, xmin, xmax, ymin, ymax, box) for x, y in zip(time_values, values)]
        d.line(points, fill=COLORS[idx % len(COLORS)], width=4)
    title_font, label_font = font(34), font(26)
    bbox = d.textbbox((0, 0), title, font=title_font)
    d.text(((WIDTH - (bbox[2] - bbox[0])) / 2, 20), title, fill=axis, font=title_font)
    d.text(((left + right) / 2 - 50, HEIGHT - 58), "Time (s)", fill=axis, font=label_font)
    d.text((18, 30), ylabel, fill=axis, font=label_font)
    legend_x = right - 360
    legend_y = top + 25
    for idx, (name, _) in enumerate(series):
        y = legend_y + idx * 38
        d.line((legend_x, y + 12, legend_x + 45, y + 12), fill=COLORS[idx % len(COLORS)], width=5)
        d.text((legend_x + 58, y), name, fill=axis, font=font(21))
    image.save(base.with_suffix(".png"), dpi=(180, 180))
    return ymin, ymax


def draw_pdf(base, title, ylabel, time_values, series, ymin, ymax):
    width, height = 800, 450
    c = canvas.Canvas(str(base.with_suffix(".pdf")), pagesize=(width, height))
    try:
        pdfmetrics.registerFont(TTFont("ArialRail", str(FONT_PATH)))
        face = "ArialRail"
    except Exception:
        face = "Helvetica"
    left, top, right, bottom = 75, 45, width - 35, height - 60
    box = (left, top, right, bottom)
    xmin, xmax = 0.0, 50.0
    c.setFont(face, 16)
    c.drawCentredString(width / 2, height - 25, title)
    c.setFont(face, 10)
    c.drawCentredString((left + right) / 2, 20, "Time (s)")
    c.saveState(); c.translate(18, (top + bottom) / 2); c.rotate(90); c.drawCentredString(0, 0, ylabel); c.restoreState()
    c.setStrokeColorRGB(.86, .88, .90)
    for i in range(11):
        x = xmin + (xmax - xmin) * i / 10
        px, _ = transform(x, ymin, xmin, xmax, ymin, ymax, box)
        c.line(px, top, px, bottom); c.drawCentredString(px, bottom - 15, f"{x:.0f}")
    for i in range(7):
        y = ymin + (ymax - ymin) * i / 6
        _, py = transform(xmin, y, xmin, xmax, ymin, ymax, box)
        c.line(left, py, right, py)
        label = f"{y:.1f}" if abs(ymax - ymin) < 20 else f"{y:.0f}"
        c.drawRightString(left - 7, py - 3, label)
    c.setStrokeColorRGB(.18, .2, .22); c.setLineWidth(1.2)
    c.line(left, top, left, bottom); c.line(left, bottom, right, bottom)
    for idx, (name, values) in enumerate(series):
        color = COLORS[idx % len(COLORS)]
        c.setStrokeColorRGB(*(v / 255 for v in color)); c.setLineWidth(1.6)
        path = c.beginPath()
        for j, (x, y) in enumerate(zip(time_values, values)):
            px, py = transform(x, y, xmin, xmax, ymin, ymax, box)
            path.moveTo(px, py) if j == 0 else path.lineTo(px, py)
        c.drawPath(path)
        ly = top + 18 + idx * 16
        c.line(right - 165, ly, right - 140, ly)
        c.setFillColorRGB(.18, .2, .22); c.drawString(right - 134, ly - 3, name)
    c.save()


def plot(name, title, ylabel, time_values, series):
    base = OUT / name
    ymin, ymax = draw_png(base, title, ylabel, time_values, series)
    draw_pdf(base, title, ylabel, time_values, series, ymin, ymax)


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    with CSV.open(encoding="utf-8-sig", newline="") as f:
        rows = list(csv.DictReader(f))
    cols = {name: [float(r[name]) for r in rows] for name in rows[0]}
    t = cols["time"]
    plot("01_train_speed", "Train Speed vs Time", "Train speed (m/s)", t,
         [("Train speed", cols["v_train"])])
    plot("02_traction_regen_power", "Traction / Regenerative Power vs Time", "Power (kW)", t,
         [("Traction power", [v / 1000 for v in cols["Ptraction"]]),
          ("Regenerative power", [v / 1000 for v in cols["Pregen"]])])
    plot("03_supercapacitor_voltage", "Supercapacitor Voltage vs Time", "Voltage (V)", t,
         [("Usc", cols["Usc"])])
    plot("04_supercapacitor_soc", "Supercapacitor SOC vs Time", "SOC (%)", t,
         [("SOC", [100 * v for v in cols["SOCsc"]])])
    plot("05_recovered_energy", "Recovered Energy vs Time", "Recovered energy (kJ)", t,
         [("Recovered energy", cols["Eregen_kJ"])])
    plot("06_regen_mechanical_braking", "Regenerative vs Mechanical Braking Force", "Force (kN)", t,
         [("Regenerative braking", [v / 1000 for v in cols["Fregen"]]),
          ("Mechanical braking", [v / 1000 for v in cols["Fmechanical"]])])
    print("FMU_COSIM_PLOTS = 6/6 PNG + 6/6 PDF")


if __name__ == "__main__":
    main()
