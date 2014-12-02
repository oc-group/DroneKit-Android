// IDroneApi.aidl
package com.o3dr.services.android.lib.model;

import com.o3dr.services.android.lib.drone.property.FootPrint;
import com.o3dr.services.android.lib.coordinate.LatLong;
import com.o3dr.services.android.lib.gcs.follow.FollowType;
import com.o3dr.services.android.lib.drone.mission.Mission;
import com.o3dr.services.android.lib.drone.mission.item.MissionItem;
import com.o3dr.services.android.lib.drone.mission.item.complex.Survey;
import com.o3dr.services.android.lib.drone.mission.item.complex.StructureScanner;
import com.o3dr.services.android.lib.drone.connection.ConnectionParameter;
import com.o3dr.services.android.lib.model.IObserver;
import com.o3dr.services.android.lib.drone.property.VehicleMode;
import com.o3dr.services.android.lib.drone.property.Parameters;

/**
* Interface used to access the drone properties.
*/
interface IDroneApi {

    /**
    * Retrieves the attribute whose type is specified by the parameter.
    * @param attributeType type of the attribute to retrieve. The list of supported
                        types is stored in {@link com.o3dr.services.android.lib.drone.attribute.AttributeType}.
    * @return Bundle object containing the requested attribute.
    */
    Bundle getAttribute(String attributeType);

    /**
    * Builds the given survey mission item.
    */
    Survey buildSurvey(in Survey survey);

    /**
    * Builds the given structure scanner mission item.
    */
    StructureScanner buildStructureScanner(in StructureScanner item);

    /*** Oneway method calls ***/

    /**
    * Register a listener to receive drone events.
    * @param observer the observer to register.
    */
    oneway void addAttributesObserver(IObserver observer);

    /**
    * Removes a drone events listener.
    * @param observer the observer to remove.
    */
    oneway void removeAttributesObserver(IObserver observer);

    /**
    * Change the vehicle mode for the connected drone.
    * @param newMode new vehicle mode.
    */
    oneway void changeVehicleMode(in VehicleMode newMode);

    /**
    * Asynchronous call used to establish connection with the device.
    */
    oneway void connect(in ConnectionParameter params);

    /**
    * Asynchronous call used to break connection with the device.
    */
    oneway void disconnect();

    /**
    * Refresh the parameters for the connected drone.
    */
    oneway void refreshParameters();

    /**
    * Write the given parameters to the connected drone.
    */
    oneway void writeParameters(in Parameters parameters);

    /**
    * Update the mission property for the drone model in memory.
    * @param mission mission to upload to the drone.
    * @param pushToDrone if true, upload the mission to the connected device.
    */
    oneway void setMission(in Mission mission, boolean pushToDrone);

    /**
    * Create a dronie mission, and upload it to the connected drone.
    */
    oneway void generateDronie();

    /**
    * Arm or disarm the connected drone.
    * @param arm true to arm, false to disarm.
    */
    oneway void arm(boolean arm);

    /**
    * Start the magnetometer calibration process.
    * @param startPoints points to start the calibration with.
    */
    oneway void startMagnetometerCalibration(in double[] pointsX, in double[] pointsY, in double[] pointsZ);

    /**
    * Stop the magnetometer calibration is one if running.
    */
    oneway void stopMagnetometerCalibration();

    /**
    * Start the imu calibration.
    */
    oneway void startIMUCalibration();

    /**
    * Send an imu calibration acknowledgement.
    */
    oneway void sendIMUCalibrationAck(int step);

    /**
    * Perform a guided take off.
    * @param altitude altitude in meters
    */
    oneway void doGuidedTakeoff(double altitude);

    /**
    * Send a guided point to the connected drone.
    * @param point guided point location
    * @param force true to enable guided mode is required.
    */
    oneway void sendGuidedPoint(in LatLong point, boolean force);

    /**
    * Set the altitude for the guided point.
    * @param altitude altitude in meters
    */
    oneway void setGuidedAltitude(double altitude);

    /**
    * Set the guided velocity.
    * @param xVel velocity in the north direction
    * @param yVel velocity in the east direction
    * @param zVel vertical velocity.
    */
    oneway void setGuidedVelocity(double xVel, double yVel, double zVel);

    /**
    * Enables follow-me if disabled.
    * @param followMode follow-me mode to use.
    */
    oneway void enableFollowMe(in FollowType followType);

    /**
    * Sets the follow-me radius.
    * @param radius radius in meters.
    */
    oneway void setFollowMeRadius(double radius);

    /**
    * Disables follow me is enabled.
    */
    oneway void disableFollowMe();

    oneway void triggerCamera();

    oneway void epmCommand(boolean release);

    oneway void loadWaypoints();
}
