package soundBrush;

import processing.core.PVector;
import processing.core.PApplet;
import java.util.ArrayList;

public class SoundBrushCirclePattern {

	private float[] audioSamples;
	private float[] fftBands;
	private ArrayList<PVector> initPoints;
	public ArrayList<PVector> points;
	private int resolution;
	private float angleUnit;
	private float scaleFactor;
	public PVector center;
	private float minSpectrumValue, maxSpectrumValue;
	private float startAngle;

	public SoundBrushCirclePattern(int res, float centerX, float centerY, float z) {
		resolution = res;

		center = new PVector(centerX, centerY, z);
		scaleFactor = 1.0f;
		startAngle = 0;
		initCircleShape();
	}

	public SoundBrushCirclePattern(int res, float centerX, float centerY, float z, float scale, float angle) {
		resolution = res;

		center = new PVector(centerX, centerY, z);
		scaleFactor = scale;
		startAngle = angle;
		initCircleShape();
	}

	private void initCircleShape() {
		initPoints = new ArrayList<PVector>(resolution);
		points = new ArrayList<PVector>(resolution);

		angleUnit = PApplet.TWO_PI / (float) resolution;
		for (int i = 0; i < resolution; i++) {
			float x = PApplet.cos(angleUnit * i + startAngle);
			float y = PApplet.sin(angleUnit * i + startAngle);
			float z = center.z;
			PVector p = new PVector(x, y, z);
			this.initPoints.add(p);
			this.points.add(new PVector(0, 0, 0));
		}
	}

	public void setStartAngle(float angle) {
		startAngle = angle;

		for (PVector p : initPoints) {
			p.rotate(startAngle);
		}
	}

	public void setSpectrumRange(float min, float max) {
		minSpectrumValue = min;
		maxSpectrumValue = max;
	}
	
	public void update(float[] fft) {
		update(null, fft);
	}

	public void update(float[] buf, float[] fft) {
		if (initPoints == null || initPoints.size() == 0)
			return;
		// if(buf == null) return;
		// audioSamples = buf;
		// fftBands = fft;

		for (int i = 0; i < fft.length; i++) {
			PVector initP = initPoints.get(i);
			PVector p = points.get(i);
			// PVector newP = PVector.mult(initP, 1 + fft[i] * scaleFactor);
			float r = PApplet.min(minSpectrumValue + fft[i] * scaleFactor, maxSpectrumValue);
			p.x = initP.x * r;
			p.y = initP.y * r;
		}
	}
}