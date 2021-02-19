package soundBrush;

import java.util.ArrayList;
import processing.core.PApplet;
import processing.core.PConstants;
import processing.core.PVector;

public class SoundBrushStroke {
	private ArrayList<SoundBrushCirclePattern> brushStroke;
	private int patternCount;

	public float minHue, maxHue;
	public float minStrokeWidth, maxStrokeWidth;

	public SoundBrushStroke() {
		brushStroke = new ArrayList<SoundBrushCirclePattern>();
		patternCount = 0;

		initStrokeStatus(100, 255, 10, 50);
	}

	public SoundBrushStroke(float minHue, float maxHue, float minStrokeWidth, float maxStrokeWidth) {
		brushStroke = new ArrayList<SoundBrushCirclePattern>();
		patternCount = 0;
		initStrokeStatus(minHue, maxHue, minStrokeWidth, maxStrokeWidth);
	}

	private void initStrokeStatus(float minHue, float maxHue, float minStrokeWidth, float maxStrokeWidth) {
		this.minHue = minHue;
		this.maxHue = maxHue;
		this.minStrokeWidth = minStrokeWidth;
		this.maxStrokeWidth = maxStrokeWidth;
	}
	
	public void addVertex(float x, float y, float z, int res, float[] fftBands,
			float spectrumScaleFactor, float startAngle) {
		addVertex(x, y, z, res, null, fftBands, spectrumScaleFactor, startAngle);
	}
	
	public void addVertex(float x, float y, float z, int res, float[] audioSamples, float[] fftBands,
			float spectrumScaleFactor, float startAngle) {
		SoundBrushCirclePattern brushCirclePattern = new SoundBrushCirclePattern(res, x, y, z, spectrumScaleFactor,
				startAngle);
		brushCirclePattern.setSpectrumRange(minStrokeWidth * 0.5f, maxStrokeWidth * 0.5f);
		brushCirclePattern.update(audioSamples, fftBands);
		brushStroke.add(brushCirclePattern);
		patternCount++;
	}
	
	public void updateAllPatterns(float[] fftBands) {
		for (SoundBrushCirclePattern brushPattern : brushStroke) {
			brushPattern.update(fftBands);
		}
	}
	
	public void updateAllPatterns(float[] audioSamples, float[] fftBands) {
		for (SoundBrushCirclePattern brushPattern : brushStroke) {
			brushPattern.update(audioSamples, fftBands);
		}
	}
	
	public void updatePatternOfIndex(int index, float[] fftBands) {
		brushStroke.get(index).update(fftBands);
	}
	
	public void updatePatternOfIndex(int index, float[] audioSamples, float[] fftBands) {
		brushStroke.get(index).update(audioSamples, fftBands);
	}

	public int size() {
		return patternCount;
	}
	
	public void draw(PApplet myParent) {
		myParent.colorMode(PConstants.HSB, 255);			
		myParent.beginShape(PConstants.QUAD_STRIP);

		for (int i = 1; i < brushStroke.size(); i++) {
			SoundBrushCirclePattern bpPrev = brushStroke.get(i - 1);
			SoundBrushCirclePattern bp = brushStroke.get(i);

			ArrayList<PVector> pointsPrev = bpPrev.points;
			ArrayList<PVector> points = bp.points;

			int lastIndex = points.size() - 1;
			float hueMax = this.maxHue;
			float hueMin = this.minHue;
			float maxMag = this.maxStrokeWidth * 0.5f;

			for (int j = 0; j < lastIndex; j++) {
				float hue1 = PApplet.map(j, 0, points.size(), hueMin, hueMax);
				float hue2 = PApplet.map(j + 1, 0, points.size(), hueMin, hueMax);
				float sat1 = 255;
				float sat2 = 255;
				float bri1 = 255 * PApplet.min(pointsPrev.get(j).mag() / maxMag, 1.0f);
				float bri2 = 255 * PApplet.min(points.get(j).mag() / maxMag, 1.0f);
				float bri3 = 255 * PApplet.min(pointsPrev.get(j + 1).mag() / maxMag, 1.0f);
				float bri4 = 255 * PApplet.min(points.get(j + 1).mag() / maxMag, 1.0f);

				myParent.fill(hue1, sat1, bri1);
				myParent.vertex(pointsPrev.get(j).x + bpPrev.center.x, pointsPrev.get(j).y + bpPrev.center.y,
						bpPrev.center.z);
				myParent.fill(hue1, sat1, bri2);
				myParent.vertex(points.get(j).x + bp.center.x, points.get(j).y + bp.center.y, bp.center.z);

				myParent.fill(hue2, sat2, bri3);
				myParent.vertex(pointsPrev.get(j + 1).x + bpPrev.center.x, pointsPrev.get(j + 1).y + bpPrev.center.y,
						bpPrev.center.z);
				myParent.fill(hue2, sat2, bri4);
				myParent.vertex(points.get(j + 1).x + bp.center.x, points.get(j + 1).y + bp.center.y, bp.center.z);

			}

			float sat1 = 255;
			float sat2 = 255;
			float bri1 = 255 * PApplet.min(pointsPrev.get(lastIndex).mag() / maxMag, 1.0f);
			float bri2 = 255 * PApplet.min(points.get(lastIndex).mag() / maxMag, 1.0f);
			float bri3 = 255 * PApplet.min(pointsPrev.get(0).mag() / maxMag, 1.0f);
			float bri4 = 255 * PApplet.min(points.get(0).mag() / maxMag, 1.0f);

			myParent.fill(hueMax, sat1, bri1);
			myParent.vertex(pointsPrev.get(lastIndex).x + bpPrev.center.x, pointsPrev.get(lastIndex).y + bpPrev.center.y,
					bpPrev.center.z);
			myParent.fill(hueMax, sat1, bri2);
			myParent.vertex(points.get(lastIndex).x + bp.center.x, points.get(lastIndex).y + bp.center.y, bp.center.z);

			myParent.fill(hueMin, sat2, bri3);
			myParent.vertex(pointsPrev.get(0).x + bpPrev.center.x, pointsPrev.get(0).y + bpPrev.center.y, bpPrev.center.z);
			myParent.fill(hueMin, sat2, bri4);
			myParent.vertex(points.get(0).x + bp.center.x, points.get(0).y + bp.center.y, bp.center.z);
		}

		myParent.endShape();
	}
	
	public SoundBrushCirclePattern get(int index) {
		return brushStroke.get(index);
	}
}
