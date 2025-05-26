# 🔧 Temperature-Based DC Motor Speed Control using PIC16F877A

This project demonstrates how to control the speed of a **DC motor** (fan) based on a simulated **temperature input** using **PWM (Pulse Width Modulation)**. The system is built using the **PIC16F877A microcontroller**, and the code was developed using **MikroC Pro for PIC**.

A **potentiometer** is used to simulate temperature changes. The system reads the analog value, converts it to a temperature-like scale, and adjusts the motor speed accordingly. A **16x2 LCD** displays the current temperature and speed in real time.

---

## 🛠️ Components Used

- **PIC16F877A Microcontroller**  
- **2x Potentiometers** (1 used to simulate temperature input)  
- **DC Motor**  
- **TIP122 Darlington Transistor** (for motor driver)  
- **Flyback Diode** (to protect the transistor from voltage spikes)  
- **16x2 LCD Display**  
- **Power Supply (5V)**  
- **Breadboard and Jumper Wires**

---

## 📌 Features

- Real-time **speed control** of a DC motor using **PWM**.  
- **Temperature simulation** using a potentiometer connected to the ADC input.  
- **LCD output** showing both temperature in Celsius and motor speed in percentage.  
- Motor switching driven by TIP122 transistor with flyback diode protection.  
- Entire code written in **MikroC Pro for PIC**.

---

## 🔌 Pin Configuration

| Signal       | PIC Pin | Description                  |  
|--------------|---------|------------------------------|  
| LCD_RS       | RB2     | LCD Register Select          |  
| LCD_EN       | RB3     | LCD Enable                   |  
| LCD_D4–D7    | RB4–RB7 | LCD Data Lines               |  
| POT (Temp)   | RA0     | Analog input (ADC0)          |  
| PWM Output   | RC2     | Connected to TIP122 base (motor driver) |

---

## 📐 Temperature to Speed Mapping

| Simulated Temperature | Speed (%) | PWM Duty Cycle |  
|------------------------|-----------|----------------|  
| < 28°C                | 0%        | 0              |  
| 28 – 35°C             | 50%       | 127            |  
| 35 – 40°C             | 75%       | 175            |  
| > 40°C                | 100%      | 255            |

---

## 📟 LCD Output Example

Temp : 37.14564C  
Speed : 75%

---

## 🧠 How It Works

1. A **potentiometer** is connected to the analog input (RA0) of the PIC16F877A.  
2. The voltage from the potentiometer is read using the **ADC module**.  
3. The analog value is converted into a simulated **temperature (in Celsius)**.  
4. According to the temperature range, a corresponding **PWM duty cycle** is applied to control motor speed.  
5. The PWM output drives the base of a **TIP122 transistor**, which switches the motor on/off at the desired speed.  
6. A **flyback diode** protects the transistor from voltage spikes caused by the motor’s inductive load.  
7. The **temperature and speed** values are displayed on a **16x2 LCD** in real time.

---

## 🚀 Future Improvements

- Replace the potentiometer with a **real temperature sensor** like **LM35** for accurate readings.  
- Add **hysteresis** to avoid frequent speed toggling near threshold temperatures.  
- Add **data logging** capabilities via UART to monitor temperature and speed.  
- Upgrade display to OLED or touchscreen for better interface.

---

## 🧪 Tools Used

- **MikroC Pro for PIC** — IDE and compiler used for writing and compiling the code.  
- **Proteus** — for simulation and testing before real hardware implementation.  
- **PIC16F877A** microcontroller — The core hardware controlling the system.

---

## 🎥 Demo Video 


[Watch PWM Project](https://youtube.com/shorts/aQhgmDaKkmM?si=wGGZJXmUk2Rc0WaN)

---

## 📞 Contact

For any questions or suggestions, feel free to contact me.
