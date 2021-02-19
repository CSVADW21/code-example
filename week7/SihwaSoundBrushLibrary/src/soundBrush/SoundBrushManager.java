package soundBrush;

import processing.core.*;
import java.util.ArrayList;
import ddf.minim.AudioBuffer;
import ddf.minim.analysis.FFT;

/**
 * Sound brush that responds to sound and visualizes sound frequency spectrum by using Minim.
 * 
 */

public class SoundBrushManager {
	
	static final public int LINEAR = 0;
	static final public int LOGARITHM = 1;

	private ArrayList<SoundBrushStroke> soundBrushStrokes;
	private SoundBrushStroke lastStroke;
	private SoundBrushStroke updateStroke;
	private int resolution;

	private int avgMode;
	private FFT fft;
	private AudioBuffer audioBuffer;
	private float[] audioSamples;
	private float[] fftBands;
	private float spectrumScaleFactor;

	private boolean liveUpdate = false;
	private boolean syncAll = false;
	private boolean showWireFrame = false;

	private int strokeIndex = 0;
	private int patternIndex = -1;
	private float patternStartAngle = 0;

	PApplet myParent;
	public final static String VERSION = "##library.prettyVersion##";

	public SoundBrushManager(PApplet theParent, AudioBuffer audioBuffer, FFT fft, int avgMode, int resolution,
			float spectrumScaleFactor) {
		myParent = theParent; 
		soundBrushStrokes = new ArrayList<SoundBrushStroke>();
		this.avgMode = avgMode;

		this.resolution = resolution;
		this.fft = fft;
		this.audioBuffer = audioBuffer;
		this.spectrumScaleFactor = spectrumScaleFactor;

		if (avgMode == LINEAR)
			fft.linAverages(resolution);
		else if (avgMode == LOGARITHM)
			fft.logAverages(22, resolution / 10);
		fftBands = new float[resolution];
	}

	public void addStroke() {
		SoundBrushStroke stroke = new SoundBrushStroke();
		soundBrushStrokes.add(stroke);
		lastStroke = stroke;
	}

	public void addStroke(float minHue, float maxHue, float minStrokeWidth, float maxStrokeWidth) {
		SoundBrushStroke stroke = new SoundBrushStroke(minHue, maxHue, minStrokeWidth, maxStrokeWidth);
		soundBrushStrokes.add(stroke);
		lastStroke = stroke;
	}

	public void addVertexToCurrentStroke(float x, float y, float z) {
		if (lastStroke != null)
			lastStroke.addVertex(x, y, z, resolution, fftBands, this.spectrumScaleFactor,
					patternStartAngle);
	}

	private void proccessNextAudioSamples() {
		audioSamples = audioBuffer.toArray();

		fft.forward(audioSamples);
		for (int i = 0; i < fft.avgSize(); i++) {
			fftBands[i] = fft.getAvg(i);
		}
	}

	public void update() {
		proccessNextAudioSamples();

		if (liveUpdate) {
			if (syncAll) {
				for (SoundBrushStroke brushStroke : soundBrushStrokes) {
					brushStroke.updateAllPatterns(fftBands);
				}
			} else if (soundBrushStrokes.size() > 0) {
				if (patternIndex == -1) {
					updateStroke = soundBrushStrokes.get(strokeIndex);
					patternIndex = 0;
				}

				updateStroke.updatePatternOfIndex(patternIndex, fftBands);

				patternIndex++;
				if (patternIndex == updateStroke.size()) {
					patternIndex = -1;
					strokeIndex++;

					strokeIndex %= soundBrushStrokes.size();
				}
			}
		}
	}

	public void draw() {
		if (showWireFrame) {
			myParent.colorMode(PConstants.RGB, 255);
			myParent.stroke(255, 100);
		} else
			myParent.noStroke();
		
		for (SoundBrushStroke brushStroke : soundBrushStrokes) {
			brushStroke.draw(myParent);

		}
	}

	public void setSpectrumScaleFactor(float s) {
		spectrumScaleFactor = s;
	}

	public void setPatternStartAngle(float a) {
		patternStartAngle = a;
	}

	public void setLiveUpdate(boolean liveUpdate) {
		this.liveUpdate = liveUpdate;
	}

	public void setSyncAll(boolean syncAll) {
		this.syncAll = syncAll;
	}

	public void setShowWireFrame(boolean showWireFrame) {
		this.showWireFrame = showWireFrame;
	}

	public void clearAllStrokes() {
		soundBrushStrokes.clear();
		lastStroke = null;
		strokeIndex = 0;
		patternIndex = -1;
	}
}
