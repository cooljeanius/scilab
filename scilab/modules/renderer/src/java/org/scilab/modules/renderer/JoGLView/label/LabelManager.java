/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2009-2010 - DIGITEO - Pierre Lando
 * Copyright (C) 2011-2012 - DIGITEO - Manuel Juliachs
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 */

package org.scilab.modules.renderer.JoGLView.label;

import org.scilab.forge.scirenderer.DrawingTools;
import org.scilab.forge.scirenderer.SciRendererException;
import org.scilab.forge.scirenderer.texture.AnchorPosition;
import org.scilab.forge.scirenderer.texture.Texture;
import org.scilab.forge.scirenderer.texture.TextureManager;
import org.scilab.forge.scirenderer.tranformations.Transformation;
import org.scilab.forge.scirenderer.tranformations.Vector3d;
import org.scilab.modules.graphic_objects.axes.Axes;
import org.scilab.modules.graphic_objects.axes.Camera;
import org.scilab.modules.graphic_objects.figure.ColorMap;
import org.scilab.modules.graphic_objects.graphicController.GraphicController;
import org.scilab.modules.graphic_objects.label.Label;
import org.scilab.modules.graphic_objects.utils.Utils;
import org.scilab.modules.renderer.JoGLView.axes.AxesDrawer;
import org.scilab.modules.renderer.JoGLView.util.ScaleUtils;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import static org.scilab.modules.graphic_objects.graphicObject.GraphicObjectProperties.__GO_AUTO_POSITION__;
import static org.scilab.modules.graphic_objects.graphicObject.GraphicObjectProperties.__GO_AUTO_ROTATION__;
import static org.scilab.modules.graphic_objects.graphicObject.GraphicObjectProperties.__GO_FONT_ANGLE__;
import static org.scilab.modules.graphic_objects.graphicObject.GraphicObjectProperties.__GO_POSITION__;

/**
 *
 * This class performs the drawing of scilab's Label entity.
 *
 * TODO, manage: {font_fractional}
 *
 * @author Manuel Juliachs
 */
public class LabelManager {

    /**
     * The {@see Map} of existing {@see Sprite}.
     */
    private final Map<String, Texture> textureMap = new ConcurrentHashMap<String, Texture>();

    /**
     * The used sprite manager.
     */
    private final TextureManager textureManager;

    /**
     * Default constructor.
     * @param textureManager the texture manager.
     */
    public LabelManager(TextureManager textureManager) {
        this.textureManager = textureManager;
    }

    /**
     * Draws the given {@see Label} with the given {@see DrawingTools}.
     * @param drawingTools the given {@see DrawingTools}.
     * @param colorMap the current {@see ColorMap}.
     * @param label the given Scilab {@see Label}.
     * @param axesDrawer the Axes drawer used to draw the label's parent Axes.
     * @throws SciRendererException if the label is not drawable.
     */
    public void draw(final DrawingTools drawingTools, final ColorMap colorMap, final Label label, AxesDrawer axesDrawer) throws SciRendererException {
        /* Only the z-axis Label may not be drawn depending on the view mode */
        boolean drawnFlag = true;
        String parentId;
        String labelId = label.getIdentifier();
        LabelPositioner labelPositioner;

        parentId = label.getParentAxes();

        if (parentId == null) {
            return;
        }

        Axes parentAxes = (Axes) GraphicController.getController().getObjectFromId(parentId);

        /* Get the positioner associated to the label */
        if (parentAxes.getXAxisLabel().equals(label.getIdentifier())) {
            labelPositioner = axesDrawer.getXAxisLabelPositioner();
        } else if (parentAxes.getYAxisLabel().equals(label.getIdentifier())) {
            labelPositioner = axesDrawer.getYAxisLabelPositioner();
        } else if (parentAxes.getZAxisLabel().equals(label.getIdentifier())) {
            labelPositioner = axesDrawer.getZAxisLabelPositioner();
            drawnFlag = (parentAxes.getViewAsEnum() == Camera.ViewType.VIEW_3D);
        } else if (parentAxes.getTitle().equals(label.getIdentifier())) {
            labelPositioner = axesDrawer.getTitlePositioner();
        } else {
            /* Do not do anything */
            return;
        }

        /*
         * The topmost transformation, which is the data transformation, must be popped before drawing
         * and restored afterwards because Labels, like Axes rulers, are drawn in box coordinates.
         */
        drawingTools.getTransformationManager().getModelViewStack().pop();

        positionAndDraw(drawingTools, colorMap, label, labelPositioner, parentAxes, axesDrawer, drawnFlag);

        drawingTools.getTransformationManager().getModelViewStack().pushRightMultiply(axesDrawer.getDataTransformation());
    }

    /**
     * Positions and draws the given Scilab {@see Label} with the given {@see DrawingTools}.
     * First, it initializes the label positioner's remaining parameters which have not been previously
     * obtained from the axis ruler drawer. It then asks the positioner the relevant values and
     * finally draws the label's sprite using these resulting values.
     * @param drawingTools the given {@see DrawingTools}.
     * @param colorMap the current {@see ColorMap}.
     * @param label the given Scilab {@see Label}.
     * @param labelPositioner the positioner used to compute the label's position.
     * @param parentAxes the label's parent Axes.
     * @param axesDrawer the Axes drawer used to draw the label's parent Axes.
     * @param drawnFlag a flag indicating whether the label must be drawn or not.
     * @throws SciRendererException if the label is not drawable.
     */
    public final void positionAndDraw(final DrawingTools drawingTools, final ColorMap colorMap, final Label label, LabelPositioner labelPositioner, Axes parentAxes, AxesDrawer axesDrawer, boolean drawnFlag) throws SciRendererException {
        boolean[] logFlags = new boolean[]{parentAxes.getXAxisLogFlag(), parentAxes.getYAxisLogFlag(), parentAxes.getZAxisLogFlag()};
        Texture labelSprite = getTexture(colorMap, label);

        labelPositioner.setLabelTexture(labelSprite);
        labelPositioner.setDrawingTools(drawingTools);
        labelPositioner.setParentAxes(parentAxes);
        labelPositioner.setAutoPosition(label.getAutoPosition());
        labelPositioner.setAutoRotation(label.getAutoRotation());
        labelPositioner.setUserRotationAngle(180.0*label.getFontAngle()/Math.PI);

        Vector3d labelUserPosition = new Vector3d(label.getPosition());

        /* Logarithmic scaling must be applied to the label's user position to obtain object coordinates */
        labelUserPosition = ScaleUtils.applyLogScale(labelUserPosition, logFlags);

        labelUserPosition = axesDrawer.getBoxCoordinates(labelUserPosition);
        labelPositioner.setLabelUserPosition(labelUserPosition);

        /* Computes the label's position values */
        labelPositioner.positionLabel();

        Vector3d labelPos = labelPositioner.getAnchorPoint();
        AnchorPosition labelAnchor = labelPositioner.getAnchorPosition();

        /* Set the lower-left corner position if auto-positioned */
        if (label.getAutoPosition()) {
            Vector3d cornerPos = labelPositioner.getLowerLeftCornerPosition();
            Vector3d objectCornerPos = axesDrawer.getObjectCoordinates(cornerPos);

            /* Apply inverse scaling to obtain user coordinates */
            objectCornerPos = ScaleUtils.applyInverseLogScale(objectCornerPos, logFlags);

            label.setPosition(new Double[]{objectCornerPos.getX(), objectCornerPos.getY(), objectCornerPos.getZ()});

            /*
             * Must be reset to true as setPosition modifies the label's auto position field.
             * To be modified.
             */
            label.setAutoPosition(true);
        }

        /* Compute and set the label's corners */
        Transformation projection = axesDrawer.getProjection();

        Vector3d[] projCorners = labelPositioner.getProjCorners();

        Vector3d[] corners = computeCorners(projection, projCorners, parentAxes);
        Double[] coordinates = cornersToCoordinateArray(corners);

        /* Set the computed coordinates */
        label.setCorners(coordinates);


        double rotationAngle = 0.0;

        if (label.getAutoRotation()) {
            rotationAngle = labelPositioner.getRotationAngle();

            label.setFontAngle(Math.PI*rotationAngle/180.0);

            /*
             * Must be reset to true as setFontAngle modifies the label's auto rotation field.
             * To be modified.
             */
            label.setAutoRotation(true);
        } else {
            rotationAngle = labelPositioner.getUserRotationAngle();
        }

        /* The label's rotation direction convention is opposite to the standard one. */
        rotationAngle = -rotationAngle;

        if (label.getVisible() && drawnFlag) {
            if (Utils.isValid(labelPos.getX(), labelPos.getY(), labelPos.getZ()) && Utils.isValid(rotationAngle)) {
                if (labelPositioner.getUseWindowCoordinates()) {
                    /* Draw in window coordinates */
                    Transformation canvasProjection = drawingTools.getTransformationManager().getCanvasProjection();
                    Vector3d projLabelPos = canvasProjection.project(labelPos);

                    drawingTools.getTransformationManager().useWindowCoordinate();
                    drawingTools.draw(labelSprite, labelAnchor, projLabelPos, rotationAngle);
                    drawingTools.getTransformationManager().useSceneCoordinate();
                } else {
                    /* Draw using box coordinates */
                    drawingTools.draw(labelSprite, labelAnchor, labelPos, rotationAngle);
                }
            }
        }

    }

    /**
     * Computes and returns the corners (in user coordinates) of a label's bounding box.
     * @param projection the projection from object coordinates to window coordinates.
     * @param projCorners the corners of the label's bounding box in window coordinates (4-element array).
     * @param parentAxes the Axes for which the coordinates are computed.
     * @return the corners of the label's bounding box in user coordinates (4-element array).
     */
    private Vector3d[] computeCorners(Transformation projection, Vector3d[] projCorners, Axes parentAxes) {
        Vector3d[] corners = new Vector3d[4];
        boolean[] logFlags = new boolean[]{parentAxes.getXAxisLogFlag(), parentAxes.getYAxisLogFlag(), parentAxes.getZAxisLogFlag()};

        corners[0] = projection.unproject(projCorners[0]);
        corners[1] = projection.unproject(projCorners[1]);
        corners[2] = projection.unproject(projCorners[2]);
        corners[3] = projection.unproject(projCorners[3]);

        /* Apply inverse logarithmic scaling in order to obtain user coordinates */
        corners[0] = ScaleUtils.applyInverseLogScale(corners[0], logFlags);
        corners[1] = ScaleUtils.applyInverseLogScale(corners[1], logFlags);
        corners[2] = ScaleUtils.applyInverseLogScale(corners[2], logFlags);
        corners[3] = ScaleUtils.applyInverseLogScale(corners[3], logFlags);

        return corners;
    }

    /**
     * Returns the positions of a bounding box's corners as an array of (x,y,z) coordinate triplets.
     * The output corners are reordered to match their order in the {@see Label} object's
     * equivalent array, respectively: lower-left, lower-right, upper-left, upper-right in the input array,
     * starting from the lower-left and going in clockwise order in the returned array.
     * @param corners of the bounding box (4-element array).
     * @return the corners' coordinates (12-element array).
     */
    private Double[] cornersToCoordinateArray(Vector3d[] corners) {
        Double[] coordinates = new Double[12];
        coordinates[0] = corners[0].getX();
        coordinates[1] = corners[0].getY();
        coordinates[2] = corners[0].getZ();

        coordinates[3] = corners[2].getX();
        coordinates[4] = corners[2].getY();
        coordinates[5] = corners[2].getZ();

        coordinates[6] = corners[3].getX();
        coordinates[7] = corners[3].getY();
        coordinates[8] = corners[3].getZ();

        coordinates[9] = corners[1].getX();
        coordinates[10] = corners[1].getY();
        coordinates[11] = corners[1].getZ();

        return coordinates;
    }

    /**
     * Updates the sprite data if needed.
     * @param id the modified object.
     * @param property the changed property.
     */
    public void update(String id, int property) {
        if (!(__GO_POSITION__ == property) && !(__GO_AUTO_POSITION__ == property)
         && !(__GO_FONT_ANGLE__ == property) && !(__GO_AUTO_ROTATION__ == property)) {
            dispose(id);
        }
    }

    /**
     * Returns the SciRenderer {@see Sprite} corresponding to the given Scilab {@see Label}.
     * @param colorMap the current color map.
     * @param label the given Scilab {@see Label}.
     * @return the SciRenderer {@see Sprite} corresponding to the given Scilab {@see Label}.
     */
    public Texture getTexture(final ColorMap colorMap, final Label label) {
        Texture texture = textureMap.get(label.getIdentifier());
        if (texture == null) {
            texture = createSprite(colorMap, label);
            textureMap.put(label.getIdentifier(), texture);
        }
        return texture;
    }

    /**
     * Creates a sprite for the given label.
     * @param colorMap the current colormap.
     * @param label the given label.
     * @return a new sprite for the given label.
     */
    private Texture createSprite(final ColorMap colorMap, final Label label) {
        LabelSpriteDrawer spriteDrawer = new LabelSpriteDrawer(colorMap, label);
        Texture sprite = textureManager.createTexture();
        sprite.setDrawer(spriteDrawer);
        return sprite;
    }

    /**
     * Disposes the texture corresponding to the given id.
     * @param id the given id.
     */
    public void dispose(String id) {
        Texture texture = textureMap.get(id);
        if (texture != null) {
            textureManager.dispose(texture);
            textureMap.remove(id);
        }
    }

    /**
     * Disposes all the label text sprites.
     */
    public void disposeAll() {
        textureManager.dispose(textureMap.values());
        textureMap.clear();
    }
}
