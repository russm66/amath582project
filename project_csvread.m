% Matt Russell
% csvread script for project
% project_csvread.m
clear all; close all; clc;

% Read the signals, time vectors all the same
t = csvread('170330033_time_us');

kv1 = csvread('170330033_voltage_kV');
kv2 = csvread('170411019_voltage_kV');
kv3 = csvread('170915057_voltage_kV');
kv4 = csvread('170915070_voltage_kV');
kv5 = csvread('190419012_voltage_kV');
kv6 = csvread('190703013_voltage_kV');


%% Plot the signals in time
ti = -20;
tf = 150;
vl = -30;
vh = 10;

figure(1);
subplot(3,2,1), plot(t,kv1,'k');
title('Discharge voltage of shot 170330033');
axis([ti tf vl vh]);
xlabel('Time (us)');
ylabel('Discharge voltage (kV)');
subplot(3,2,2), plot(t,kv2,'k');
title('Discharge voltage of shot 170411019');
axis([ti tf vl vh]);
xlabel('Time (us)');
ylabel('Discharge voltage (kV)');
subplot(3,2,3), plot(t,kv3,'k');
title('Discharge voltage of shot 170915057');
axis([ti tf vl vh]);
xlabel('Time (us)');
ylabel('Discharge voltage (kV)');
subplot(3,2,4), plot(t,kv4,'k');
title('Discharge voltage of shot 170915070');
axis([ti tf vl vh]);
xlabel('Time (us)');
ylabel('Discharge voltage (kV)');
subplot(3,2,5), plot(t,kv5,'k');
title('Discharge voltage of shot 190419012');
axis([ti tf vl vh]);
xlabel('Time (us)');
ylabel('Discharge voltage (kV)');
subplot(3,2,6), plot(t,kv6,'k');
title('Discharge voltage of shot 190703013');
axis([ti tf vl vh]);
xlabel('Time (us)');
ylabel('Discharge voltage (kV)');

%% look at frequency content
% lengths all the same
p = floor(log2(length(t))); % num datapoints must be power of 2 for fft
n = 2^p; % fourier modes

tfft = t(1:n);
kv1f = kv1(1:n);
kv2f = kv2(1:n);
kv3f = kv3(1:n);
kv4f = kv4(1:n);
kv5f = kv5(1:n);
kv6f = kv6(1:n);

L = 1;
w = ((2*pi)/L)*[0:(n/2-1) -n/2:-1]; ws = fftshift(w)';


%% Plot FFT
figure(2);
subplot(3,2,1), plot(ws,abs(fftshift(fft(kv1f)))/abs(max(fft(kv1f))));
title('Frequency content of shot 170330033');
axis([-2e4 2e4 0 1]);
xlabel('Angular Frequency (rad/sec)');
ylabel('Amplitude');
subplot(3,2,2), plot(ws,abs(fftshift(fft(kv2f)))/abs(max(fft(kv2f))));
title('Frequency content of shot 170411019');
axis([-2e4 2e4 0 1]);
xlabel('Angular Frequency (rad/sec)');
ylabel('Amplitude');
subplot(3,2,3), plot(ws,abs(fftshift(fft(kv3f)))/abs(max(fft(kv3f))));
title('Frequency content of shot 170915057');
axis([-2e4 2e4 0 1]);
xlabel('Angular Frequency (rad/sec)');
ylabel('Amplitude');
subplot(3,2,4), plot(ws,abs(fftshift(fft(kv4f)))/abs(max(fft(kv4f))));
title('Frequency content of shot 170915070');
axis([-2e4 2e4 0 1]);
xlabel('Angular Frequency (rad/sec)');
ylabel('Amplitude');
subplot(3,2,5), plot(ws,abs(fftshift(fft(kv5f)))/abs(max(fft(kv5f))));
title('Frequency content of shot 190419012');
axis([-2e4 2e4 0 1]);
xlabel('Angular Frequency (rad/sec)');
ylabel('Amplitude');
subplot(3,2,6), plot(ws,abs(fftshift(fft(kv6f)))/abs(max(fft(kv6f))));
title('Frequency content of shot 190703013');
axis([-2e4 2e4 0 1]);
xlabel('Angular Frequency (rad/sec)');
ylabel('Amplitude');

%% Plot Gaussian filtered FFT
mid = length(kv1f)/2;
dcwidth = 200; %

kv1fdc = fftshift(fft(kv1f)); 
kv2fdc = fftshift(fft(kv2f));
kv3fdc = fftshift(fft(kv3f));
kv4fdc = fftshift(fft(kv4f));
kv5fdc = fftshift(fft(kv5f));
kv6fdc = fftshift(fft(kv6f));

for i=(mid-dcwidth):(mid+dcwidth)
    kv1fdc(i) = 0;
    kv2fdc(i) = 0;
    kv3fdc(i) = 0;
    kv4fdc(i) = 0;
    kv5fdc(i) = 0;
    kv6fdc(i) = 0;
end

figure(3);
subplot(3,2,1), plot(ws,abs(kv1fdc)/abs(max(kv1fdc)));
title('DC-Filtered Spectral content of shot 170330033');
% axis([-2e4 2e4 0 1]);
xlabel('Angular Frequency (rad/sec)');
ylabel('Amplitude');
subplot(3,2,2), plot(ws,abs(kv2fdc)/abs(max(kv2fdc)));
title('DC-Filtered Spectral content of shot 170411019');
% axis([-2e4 2e4 0 1]);
xlabel('Angular Frequency (rad/sec)');
ylabel('Amplitude');
subplot(3,2,3), plot(ws,abs(kv3fdc)/abs(max(kv3fdc)));
title('DC-Filtered Spectral content of shot 170915057');
% axis([-2e4 2e4 0 1]);
xlabel('Angular Frequency (rad/sec)');
ylabel('Amplitude');
subplot(3,2,4), plot(ws,abs(kv4fdc)/abs(max(kv4fdc)));
title('DC-Filtered Spectral content of shot 170915070');
% axis([-2e4 2e4 0 1]);
xlabel('Angular Frequency (rad/sec)');
ylabel('Amplitude');
subplot(3,2,5), plot(ws,abs(kv5fdc)/abs(max(kv5fdc)));
title('DC-Filtered Spectral content of shot 190419012');
% axis([-2e4 2e4 0 1]);
xlabel('Angular Frequency (rad/sec)');
ylabel('Amplitude');
subplot(3,2,6), plot(ws,abs(kv6fdc)/abs(max(kv6fdc)));
title('DC-Filtered Spectral content of shot 190703013');
% axis([-2e4 2e4 0 1]);
xlabel('Angular Frequency (rad/sec)');
ylabel('Amplitude');

%% ifft kvmfdc and plot
kv1dc = ifftshift(ifft(kv1fdc));
kv2dc = ifftshift(ifft(kv2fdc));
kv3dc = ifftshift(ifft(kv3fdc));
kv4dc = ifftshift(ifft(kv4fdc));
kv5dc = ifftshift(ifft(kv5fdc));
kv6dc = ifftshift(ifft(kv6fdc));

% figure(4);
% subplot(3,2,1), plot(tfft,kv1dc,'k');
% title('Discharge voltage of shot 170330033');
% axis([ti tf vl vh]);
% xlabel('Time (us)');
% ylabel('Discharge voltage (kV)');
% subplot(3,2,2), plot(tfft,kv2dc,'k');
% title('Discharge voltage of shot 170411019');
% axis([ti tf vl vh]);
% xlabel('Time (us)');
% ylabel('Discharge voltage (kV)');
% subplot(3,2,3), plot(tfft,kv3dc,'k');
% title('Discharge voltage of shot 170915057');
% axis([ti tf vl vh]);
% xlabel('Time (us)');
% ylabel('Discharge voltage (kV)');
% subplot(3,2,4), plot(tfft,kv4dc,'k');
% title('Discharge voltage of shot 170915070');
% axis([ti tf vl vh]);
% xlabel('Time (us)');
% ylabel('Discharge voltage (kV)');
% subplot(3,2,5), plot(tfft,kv5dc,'k');
% title('Discharge voltage of shot 190419012');
% axis([ti tf vl vh]);
% xlabel('Time (us)');
% ylabel('Discharge voltage (kV)');
% subplot(3,2,6), plot(tfft,kv6dc,'k');
% title('Discharge voltage of shot 190703013');
% axis([ti tf vl vh]);
% xlabel('Time (us)');
% ylabel('Discharge voltage (kV)');