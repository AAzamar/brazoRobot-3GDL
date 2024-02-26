#include <PID_v1.h>
#include <Servo.h>

const int pot_1 = A0;
const int pot_2 = A1;
const int pot_3 = A2;
const byte encA = 2;
const byte encB = 3;
const byte motor1PWM = 6;
const byte motor1Direction = 7;
const byte motor2PWM = 5;
const byte motor2Direction = 4;
const byte home = 8;

double Setpoint1, Input1, Output1, LSetpoint1 = 0, err1 = 0, kp1, ki1, kd1, outMax1, outMin1;
volatile long contador1 = 0;
double Setpoint2, Input2, Output2, LSetpoint2 = 0, err2 = 0, kp2, ki2, kd2, outMax2, outMin2;
volatile long contador2 = 0;
Servo servo;
int Setpoint3, LSetpoint3=0, out1 = 0, out2 = 0;
double aux1 = 0, aux2 = 0, aux3 = 0;
int a =0;
PID myPID1(&Input1, &Output1, &Setpoint1, 0.0, 0.0, 0.0,P_ON_M, DIRECT);
PID myPID2(&Input2, &Output2, &Setpoint2, 0.0, 0.0, 0.0,P_ON_M, DIRECT);

void setup() {
  Serial.begin(9600);
  TCCR0B = TCCR0B & B11111000 | 1; // set timer 0 divisor to     1 for PWM frequency of 62500.00 Hz (pin5, poin6)
  //TCCR1B = TCCR1B & B11111000 | 1;    // set timer 1 divisor to  1 for PWM frequency of 31372.55 Hz
  pinMode(motor1PWM, OUTPUT);
  pinMode(motor1Direction, OUTPUT);
  pinMode(motor2PWM, OUTPUT);
  pinMode(motor2Direction, OUTPUT);
  outMax1 = 65;   outMin1 = 50;  kp1 = 0.1;  ki1 = 100;  kd1 = 10000000;
  //outMax1 = 30;   outMin1 = 20;
  myPID1.SetSampleTime(25);
  myPID1.SetOutputLimits(outMin1, outMax1);
  myPID1.SetTunings(kp1, ki1, kd1);
  myPID1.SetMode(AUTOMATIC);//MANUAL
  outMax2 = 150;  outMin2 = 100;  kp2 = 100;  ki2 = 0;    kd2 = 1000;
  myPID2.SetSampleTime(25);
  myPID2.SetOutputLimits(outMin2, outMax2);
  myPID2.SetTunings(kp2, ki2, kd2);
  myPID2.SetMode(AUTOMATIC);
  servo.attach(9);
  servo.write(0);
  pinMode(home, INPUT);
  moveRobotToHome();
  pinMode(home, OUTPUT);
  pinMode(encA, INPUT);
  pinMode(encB, INPUT);
  attachInterrupt(digitalPinToInterrupt(encA), encoder1, RISING);
  attachInterrupt(digitalPinToInterrupt(encB), encoder2, RISING);
}

void loop() {  
  aux1 = map(analogRead(pot_1),0,1023,0,668);
  if (abs(aux1-LSetpoint1) > 4) {
    Setpoint1 = map(analogRead(pot_1),0,1023,0,668);
  }
  Input1 = (double)contador1;
  while (!myPID1.Compute());
  err1 = Setpoint1 - LSetpoint1;
  if (err1 < 0) {   // > sentido horario,  < Sentido antihorario
    digitalWrite(motor1Direction, LOW);
    if ((abs(err1) - contador1) > 0) {
      analogWrite(motor1PWM, abs(Output1));
    } else {
      digitalWrite(motor1PWM, LOW);
      LSetpoint1 = Setpoint1;
      contador1 = 0;
    }
  }
  else if (err1 == 0) {
    digitalWrite(motor1Direction, LOW);
    digitalWrite(motor1PWM, LOW);
  }
  else {
    digitalWrite(motor1Direction, HIGH);
    if ((abs(err1) - contador1) > 0) {
      analogWrite(motor1PWM, 230-Output1); //230-Output1
    } else {
      digitalWrite(motor1PWM, HIGH);
      LSetpoint1 = Setpoint1;
      contador1 = 0;
    }    
  }
  //*******************************************************************************//
  aux2 = map(analogRead(pot_2),0,1023,0,2640);
  if (abs(aux2-LSetpoint2) > 25) {
    Setpoint2 = map(analogRead(pot_2),0,1023,0,2640);
  }
  Input2 = (double)contador2;
  while (!myPID2.Compute());
  err2 = Setpoint2 - LSetpoint2;
  if (err2 > 0) { // > sentido antihorario < sentido horario
    digitalWrite(motor2Direction, LOW);
    if ((abs(err2) - contador2) > 0) {
      analogWrite(motor2PWM, abs(Output2));
    } else {
      digitalWrite(motor2PWM, LOW);
      LSetpoint2 = Setpoint2;
      contador2 = 0;
    }
  }
  else if (err2 == 0) {
    digitalWrite(motor2Direction, LOW);
    analogWrite(motor2PWM, LOW);
  }
  else {
    digitalWrite(motor2Direction, HIGH);
    if ((abs(err2) - contador2) > 0) {
      analogWrite(motor2PWM, 220-Output2);
    } else {
      digitalWrite(motor2PWM, HIGH);
      LSetpoint2 = Setpoint2;
      contador2 = 0;
    }
  }
//*******************************************************************************//
  aux3 = map(analogRead(pot_3),0,1023,0,180);
  if (abs(aux3-LSetpoint3) > 4) {
    Setpoint3 = map(analogRead(pot_3),0,1023,0,180);
    LSetpoint3 = Setpoint3;
  }
  servo.write(Setpoint3);

  /*
  a = LSetpoint3;
  if (a<Setpoint3) {
    a = a+0.1;
  } else if (a == Setpoint3) {
    servo.write(a);
  } else {
    a = a-0.1; 
  }
  servo.write(a);
  */
  
  Serial.print(aux1);
  Serial.print(",");
  Serial.print(aux2);
  Serial.print(",");
  Serial.print(aux3);
  Serial.write(13);
  Serial.write(10);
}

void encoder1() {
  contador1++;
}

void encoder2() {
  contador2++;
}

void moveRobotToHome() {
  while (digitalRead(home) == LOW) {
    analogWrite(motor2PWM, 155);
    digitalWrite(motor2Direction, HIGH);
  }
  digitalWrite(motor2Direction, LOW);
  digitalWrite(motor2PWM, LOW);
}

