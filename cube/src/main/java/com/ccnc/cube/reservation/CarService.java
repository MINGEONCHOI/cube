package com.ccnc.cube.reservation;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CarService {
	
	@Autowired
	private CarRepository carRepository;
		
	@Transactional
	public List<Car>getCarlist(){
		List<Car> carList = carRepository.findAll();
		return carList; 
	}
	
	@Transactional(readOnly = true)
	public Car getCar(Integer carId) {
		Car findCar = carRepository.findById(carId).orElseGet(()->{
			return new Car();
		});
		
		return findCar;
	}
	

	
	
	
	
}
